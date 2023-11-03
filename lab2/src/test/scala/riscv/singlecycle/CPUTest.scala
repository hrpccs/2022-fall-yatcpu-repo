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

package riscv.singlecycle

import board.basys3.BootStates
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import peripheral.{InstructionROM, Memory, ROMLoader}
import riscv.core.{CPU, CSRRegister, ProgramCounter}
import riscv.{Parameters, TestAnnotations}

import java.nio.{ByteBuffer, ByteOrder}


class TestTopModule(exeFilename: String) extends Module {
  val io = IO(new Bundle {
    val mem_debug_read_address = Input(UInt(Parameters.AddrWidth))
    val regs_debug_read_address = Input(UInt(Parameters.PhysicalRegisterAddrWidth))
    val csr_regs_debug_read_address = Input(UInt(Parameters.CSRRegisterAddrWidth))
    val interrupt_flag = Input(UInt(Parameters.InterruptFlagWidth))


    val regs_debug_read_data = Output(UInt(Parameters.DataWidth))
    val mem_debug_read_data = Output(UInt(Parameters.DataWidth))
    val csr_regs_debug_read_data = Output(UInt(Parameters.DataWidth))
    val pc_debug_read = Output(UInt(Parameters.AddrWidth));
  })

  val mem = Module(new Memory(8192))
  val instruction_rom = Module(new InstructionROM(exeFilename))
  val rom_loader = Module(new ROMLoader(instruction_rom.capacity))

  rom_loader.io.rom_data := instruction_rom.io.data
  rom_loader.io.load_address := Parameters.EntryAddress
  instruction_rom.io.address := rom_loader.io.rom_address

  val CPU_clkdiv = RegInit(UInt(2.W), 0.U)
  val CPU_tick = Wire(Bool())
  val CPU_next = Wire(UInt(2.W))
  CPU_next := Mux(CPU_clkdiv === 3.U, 0.U, CPU_clkdiv + 1.U)
  CPU_tick := CPU_clkdiv === 0.U
  CPU_clkdiv := CPU_next

  withClock(CPU_tick.asClock) {
    val cpu = Module(new CPU)
    cpu.io.instruction_valid := rom_loader.io.load_finished
    mem.io.instruction_address := cpu.io.instruction_address
    cpu.io.instruction := mem.io.instruction
    cpu.io.interrupt_flag := io.interrupt_flag

    when(!rom_loader.io.load_finished) {
      rom_loader.io.bundle <> mem.io.bundle
      cpu.io.memory_bundle.read_data := 0.U
    }.otherwise {
      rom_loader.io.bundle.read_data := 0.U
      cpu.io.memory_bundle <> mem.io.bundle
    }

    cpu.io.regs_debug_read_address := io.regs_debug_read_address
    cpu.io.csr_regs_debug_read_address := io.csr_regs_debug_read_address
    io.regs_debug_read_data := cpu.io.regs_debug_read_data
    io.csr_regs_debug_read_data := cpu.io.csr_regs_debug_read_data
    io.pc_debug_read := cpu.io.instruction_address
  }

  mem.io.debug_read_address := io.mem_debug_read_address
  io.mem_debug_read_data := mem.io.debug_read_data
}


class FibonacciTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Single Cycle CPU with CSR and CLINT"
  it should "calculate recursively fibonacci(10)" in {
    test(new TestTopModule("fibonacci.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
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
  behavior of "Single Cycle CPU with CSR and CLINT"
  it should "quicksort 10 numbers" in {
    test(new TestTopModule("quicksort.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
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

class ByteAccessTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Single Cycle CPU with CSR and CLINT"
  it should "store and load single byte" in {
    test(new TestTopModule("sb.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
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

class SimpleTrapTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Single Cycle CPU with CSR and CLINT"
  it should "jump to trap handler and then return" in {
    test(new TestTopModule("simpletest.asmbin")).withAnnotations(TestAnnotations.annos) { c =>
      for (i <- 1 to 1000) {
        c.clock.step()
        c.io.mem_debug_read_address.poke((i * 4).U) // Avoid timeout
      }
      c.io.mem_debug_read_address.poke(4.U)
      c.clock.step()
      c.io.mem_debug_read_data.expect(0xDEADBEEFL.U)
      c.io.interrupt_flag.poke(0x1.U)
      c.clock.step(5)
      c.io.interrupt_flag.poke(0.U)
      for (i <- 1 to 1000) {
        c.clock.step()
        c.io.mem_debug_read_address.poke((i * 4).U) // Avoid timeout
      }
      c.io.csr_regs_debug_read_address.poke(0x300.U) // CSRRegister.MSTATUS
      c.io.csr_regs_debug_read_data.expect(0x1888.U)
      c.io.csr_regs_debug_read_address.poke(0x342.U) // CSRRegister.MCAUSE
      c.io.csr_regs_debug_read_data.expect(0x80000007L.U)
      c.clock.step(10)
      c.io.mem_debug_read_address.poke(0x4.U)
      c.clock.step()
      c.io.mem_debug_read_data.expect(0x2022L.U)
    }
  }
}
