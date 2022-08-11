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
import riscv.core.CPU
import riscv.{ImplementationType, Parameters}

class Top extends Module {
  val binaryFilename = "tetris.asmbin"
  val io = IO(new Bundle() {
    val hdmi_clk_n = Output(Bool())
    val hdmi_clk_p = Output(Bool())
    val hdmi_data_n = Output(UInt(3.W))
    val hdmi_data_p = Output(UInt(3.W))
    val hdmi_hpdn = Output(Bool())

    val tx = Output(Bool())
    val rx = Input(Bool())

    val led = Output(UInt(4.W))
  })
  io.led := 15.U(4.W)

  val cpu = Module(new CPU(ImplementationType.ThreeStage))
  cpu.io.interrupt_flag := 0.U
  cpu.io.debug_read_address := 0.U

  val instruction_rom = Module(new InstructionROM(binaryFilename))
  instruction_rom.io.address := (cpu.io.instruction_address - Parameters.EntryAddress) >> 2
  cpu.io.instruction := instruction_rom.io.data

  val mem = Module(new Memory(Parameters.MemorySizeInWords))
  val hdmi_display = Module(new HDMIDisplay)
  val display = Module(new CharacterDisplay)
  val timer = Module(new Timer)
  val uart = Module(new Uart(frequency = 125000000, baudRate = 115200))
  val dummy = Module(new Dummy)
  display.io.bundle <> dummy.io.bundle
  mem.io.bundle <> dummy.io.bundle
  timer.io.bundle <> dummy.io.bundle
  uart.io.bundle <> dummy.io.bundle
  io.tx := uart.io.txd
  uart.io.rxd := io.rx
  cpu.io.interrupt_flag := uart.io.signal_interrupt ## timer.io.signal_interrupt
  mem.io.debug_read_address := 0.U
  cpu.io.debug_read_address := 0.U
  when(cpu.io.device_select === 4.U) {
    timer.io.bundle <> cpu.io.memory_bundle
  }.elsewhen(cpu.io.device_select === 2.U) {
    uart.io.bundle <> cpu.io.memory_bundle
  }.elsewhen(cpu.io.device_select === 1.U) {
    display.io.bundle <> cpu.io.memory_bundle
  }.otherwise {
    mem.io.bundle <> cpu.io.memory_bundle
  }

  display.io.x := hdmi_display.io.x
  display.io.y := hdmi_display.io.y
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