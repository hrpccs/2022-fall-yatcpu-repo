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

package board.basys3

import chisel3._
import chisel3.experimental.ChiselEnum
import chisel3.util._
import riscv._
import peripheral._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import riscv.core.CPU

class Top extends Module {
  val binaryFilename = "tetris.asmbin"
  val io = IO(new Bundle {
    val switch = Input(UInt(16.W))

    val segs = Output(UInt(8.W))
    val digit_mask = Output(UInt(4.W))

    val led = Output(UInt(16.W))
  })

  val cpu = Module(new CPU(ImplementationType.ThreeStage))

  val instruction_rom = Module(new InstructionROM(binaryFilename))
  instruction_rom.io.address := (cpu.io.instruction_address - Parameters.EntryAddress) >> 2
  cpu.io.instruction := instruction_rom.io.data

  val mem = Module(new Memory(Parameters.MemorySizeInWords))
  mem.io.bundle <> cpu.io.memory_bundle

  cpu.io.interrupt_flag := 0.U

  cpu.io.debug_read_address := 0.U
  mem.io.debug_read_address := 0.U

  mem.io.debug_read_address := io.switch(15, 1).asUInt << 2
  io.led := Mux(
    io.switch(0),
    mem.io.debug_read_data(31, 16).asUInt,
    mem.io.debug_read_data(15, 0).asUInt,
  )

  val onboard_display = Module(new OnboardDigitDisplay)
  io.digit_mask := onboard_display.io.digit_mask

  val sysu_logo = Module(new SYSULogo)
  sysu_logo.io.digit_mask := io.digit_mask

  val seg_mux = Module(new SegmentMux)
  seg_mux.io.digit_mask := io.digit_mask
  seg_mux.io.numbers := io.led

  io.segs := MuxLookup(
    io.switch,
    seg_mux.io.segs,
    IndexedSeq(
      0.U -> sysu_logo.io.segs
    )
  )
}

object VerilogGenerator extends App {
  (new ChiselStage).execute(Array("-X", "verilog", "-td", "verilog/basys3"), Seq(ChiselGeneratorAnnotation(() => new Top)))
}