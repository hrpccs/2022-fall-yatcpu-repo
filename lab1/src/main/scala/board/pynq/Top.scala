// Copyright 2022 Canbin Huang
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

package board.pynq

import chisel3._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import peripheral._
import riscv.Parameters
import riscv.core.{CPU, ProgramCounter}

class Top extends Module {
  val binaryFilename = "hdmi_test.asmbin"
  val io = IO(new Bundle() {
    val hdmi_clk_n = Output(Bool())
    val hdmi_clk_p = Output(Bool())
    val hdmi_data_n = Output(UInt(3.W))
    val hdmi_data_p = Output(UInt(3.W))
    val hdmi_hpdn = Output(Bool())

    val led = Output(UInt(4.W))
  })

  val cpu = Module(new CPU)
  val mem = Module(new Memory(Parameters.MemorySizeInWords))
  val hdmi_display = Module(new HDMIDisplay)
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

  cpu.io.debug_read_address := 0.U

  mem.io.bundle <> cpu.io.memory_bundle

  when(cpu.io.deviceSelect === 1.U) {
    display.io.bundle <> cpu.io.memory_bundle
  }.otherwise {
    mem.io.bundle <> cpu.io.memory_bundle
  }

  inst_mem.io.address := (cpu.io.instruction_address - ProgramCounter.EntryAddress) >> 2
  cpu.io.instruction := inst_mem.io.data

  io.led := 15.U(4.W)

  display.io.x := hdmi_display.io.x_next
  display.io.y := hdmi_display.io.y_next
  display.io.video_on := hdmi_display.io.video_on
  hdmi_display.io.rgb := display.io.rgb

  io.hdmi_hpdn := 1.U
  io.hdmi_data_n := hdmi_display.io.TMDSdata_n
  io.hdmi_data_p := hdmi_display.io.TMDSdata_p
  io.hdmi_clk_n := hdmi_display.io.TMDSclk_n
  io.hdmi_clk_p := hdmi_display.io.TMDSclk_p
}

object VerilogGenerator extends App {
  (new ChiselStage).execute(Array("-X", "verilog", "-td", "verilog/pynq"), Seq(ChiselGeneratorAnnotation(() => new Top)))
}