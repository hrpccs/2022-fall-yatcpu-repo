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
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import chisel3.util._
import peripheral.{CharacterDisplay, InstructionROM, Memory, VGADisplay}
import riscv._
import riscv.core.{CPU, ProgramCounter}

object BootStates extends ChiselEnum {
  val Init, Loading, Finished = Value
}

class Top extends Module {
  val binaryFilename = "tetris.asmbin"
  val io = IO(new Bundle {
    val switch = Input(UInt(16.W))

    val segs = Output(UInt(8.W))
    val digit_mask = Output(UInt(4.W))

    val hsync = Output(Bool())
    val vsync = Output(Bool())
    val rgb = Output(UInt(12.W))
    val led = Output(UInt(16.W))

  })

  val cpu = Module(new CPU)
  val mem = Module(new Memory(Parameters.MemorySizeInWords))

  val vga_display = Module(new VGADisplay)
  val display = Module(new CharacterDisplay)
  val inst_mem = Module(new InstructionROM(binaryFilename))

  display.io.bundle.address := 0.U
  display.io.bundle.write_enable := false.B
  display.io.bundle.write_data := 0.U
  display.io.bundle.write_strobe := VecInit(Seq.fill(Parameters.WordSize)(false.B))
  mem.io.bundle.address := 0.U
  mem.io.bundle.write_enable := false.B
  mem.io.bundle.write_data := 0.U
  mem.io.bundle.write_strobe := VecInit(Seq.fill(Parameters.WordSize)(false.B))
  mem.io.debug_read_address := 0.U

  cpu.io.reg_debug_read_address := 0.U

  when(cpu.io.DataMemBundle.address(29)) {
    display.io.bundle <> cpu.io.DataMemBundle
  }.otherwise {
    mem.io.bundle <> cpu.io.DataMemBundle
  }

  inst_mem.io.address := (cpu.io.InstMemBundle.address - ProgramCounter.EntryAddress) >> 2
  cpu.io.InstMemBundle.read_data := inst_mem.io.data

  io.hsync := vga_display.io.hsync
  io.vsync := vga_display.io.vsync

  display.io.x := vga_display.io.x
  display.io.y := vga_display.io.y
  display.io.video_on := vga_display.io.video_on

  io.rgb := display.io.rgb

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