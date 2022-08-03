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

package board.verilator

import chisel3._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import peripheral._
import riscv.{ImplementationType, Parameters}
import riscv.core.CPU

class Top extends Module {
  val io = IO(new Bundle() {
    val instruction_address = Output(UInt(Parameters.AddrWidth))
    val instruction = Input(UInt(Parameters.DataWidth))

    val reg_debug_read_address = Input(UInt(Parameters.AddrWidth))
    val reg_debug_read_data = Output(UInt(Parameters.DataWidth))

    val memory_bundle = Flipped(new RAMBundle)
  })

  val cpu = Module(new CPU(ImplementationType.FiveStage))

  cpu.io.debug_read_address := io.reg_debug_read_address
  io.reg_debug_read_data := cpu.io.debug_read_data

  io.memory_bundle <> cpu.io.memory_bundle
  io.instruction_address := cpu.io.instruction_address
  cpu.io.instruction := io.instruction

  cpu.io.interrupt_flag := 0.U
}

object VerilogGenerator extends App {
  (new ChiselStage).execute(Array("-X", "verilog", "-td", "verilog/verilator"), Seq(ChiselGeneratorAnnotation(() =>
    new Top())))
}