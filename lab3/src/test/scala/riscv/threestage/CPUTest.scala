// Copyright 2021 Howard Lau
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package riscv.threestage

import board.basys3.BootStates
import bus.BusSwitch
import chisel3._
import chisel3.util.{is, switch}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import peripheral.{Memory, Timer}
import riscv.core.threestage.ProgramCounter
import riscv.{Parameters, TestAnnotations}

import java.nio.{ByteBuffer, ByteOrder}

class TestInstructionROM(asmBin: String) extends Module {
  val io = IO(new Bundle {
    val address = Input(UInt(32.W))
    val data = Output(UInt(32.W))
  })

  val (insts, capacity) = loadAsmBinary(asmBin)
  val mem = RegInit(insts)
  io.data := mem(io.address)

  def loadAsmBinary(filename: String) = {
    val inputStream = getClass.getClassLoader.getResourceAsStream(filename)
    var instructions = new Array[BigInt](0)
    val arr = new Array[Byte](4)
    while (inputStream.read(arr) == 4) {
      val instBuf = ByteBuffer.wrap(arr)
      instBuf.order(ByteOrder.LITTLE_ENDIAN)
      val inst = BigInt(instBuf.getInt() & 0xFFFFFFFFL)
      instructions = instructions :+ inst
    }
    (VecInit((instructions.map(inst => inst.U(32.W))).toIndexedSeq), instructions.length)
  }
}

class TestTopModule(exeFilename: String) extends Module {
  val io = IO(new Bundle {
    val mem_debug_read_address = Input(UInt(Parameters.AddrWidth))
    val regs_debug_read_address = Input(UInt(Parameters.PhysicalRegisterAddrWidth))
    val regs_debug_read_data = Output(UInt(Parameters.DataWidth))
    val mem_debug_read_data = Output(UInt(Parameters.DataWidth))

    val interrupt = Input(UInt(Parameters.InterruptFlagWidth))
    val boot_state = Output(UInt())
  })

  val deviceSelect = io.mem_debug_read_address(31,29)
  val addressInDevice = Cat(0.U(3.W),io.mem_debug_read_address(28,0))

  val instruction_rom = Module(new TestInstructionROM(exeFilename))
  val mem = Module(new Memory(8192))
  val cpu = Module(new CPU)
  val timer = Module(new Timer)

  instruction_rom.io.address := rom_loader.io.rom_address
  rom_loader.io.channels <> dummy.io.channels
  switch(boot_state) {
    is(BootStates.Init) {
      rom_loader.io.load_start := true.B
      boot_state := BootStates.Loading
      rom_loader.io.channels <> mem.io.channels
    }
    is(BootStates.Loading) {
      rom_loader.io.load_start := false.B
      rom_loader.io.channels <> mem.io.channels
      when(rom_loader.io.load_finished) {
        boot_state := BootStates.Finished
      }
    }
    is(BootStates.Finished) {
      rom_loader.io.load_start := false.B
      cpu.io.stall_flag_bus := false.B
      cpu.io.instruction_valid := true.B
    }
  }
  bus_switch.io.slaves(4) <> timer.io.channels

  mem.io.debug_read_address := io.mem_debug_read_address
  cpu.io.debug_read_address := io.regs_debug_read_address
  io.regs_debug_read_data := cpu.io.debug_read_data
  io.mem_debug_read_data := mem.io.debug_read_data

  cpu.io.interrupt_flag := io.interrupt
}


class FibonacciTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CPU"
  it should "calculate recursively fibonacci(10)" in {
    test(new TestTopModule("fibonacci.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
      c.io.interrupt.poke(0.U)
      for (i <- 1 to 50) {
        c.clock.step(1000)
        c.io.mem_debug_read_address.poke((i * 4).U) // Avoid timeout
      }

      c.io.mem_debug_read_address.poke(4.U)
      c.clock.step()
      c.io.mem_debug_read_data.expect(55.U)
    }
  }
}

class QuicksortTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CPU"
  it should "quicksort 10 numbers" in {
    test(new TestTopModule("quicksort.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
      c.io.interrupt.poke(0.U)
      for (i <- 1 to 50) {
        c.clock.step(1000)
        c.io.mem_debug_read_address.poke((i * 4).U) // Avoid timeout
      }
      for (i <- 1 to 10) {
        c.io.mem_debug_read_address.poke((4 * i).U)
        c.clock.step()
        c.io.mem_debug_read_data.expect((i - 1).U)
      }
    }
  }
}

class MMIOTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CPU"
  it should "read and write timer register" in {
    test(new TestTopModule("mmio.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
      c.io.interrupt.poke(0.U)
      for (i <- 1 to 200) {
        c.clock.step()
        c.io.mem_debug_read_address.poke((i * 4).U) // Avoid timeout
      }
      c.io.regs_debug_read_address.poke(5.U)
      c.io.regs_debug_read_data.expect(100000000.U)
      c.io.regs_debug_read_address.poke(6.U)
      c.io.regs_debug_read_data.expect(0xBEEF.U)
    }
  }
}

class ByteAccessTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CPU"
  it should "store and load single byte" in {
    test(new TestTopModule("sb.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
      c.io.interrupt.poke(0.U)
      for (i <- 1 to 500) {
        c.clock.step()
        c.io.mem_debug_read_address.poke((i * 4).U) // Avoid timeout
      }
      c.io.regs_debug_read_address.poke(5.U)
      c.io.regs_debug_read_data.expect(0xDEADBEEFL.U)
      c.io.regs_debug_read_address.poke(6.U)
      c.io.regs_debug_read_data.expect(0xEF.U)
      c.io.regs_debug_read_address.poke(1.U)
      c.io.regs_debug_read_data.expect(0x15EF.U)
    }
  }
}
