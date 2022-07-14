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
import riscv.Parameters
import riscv.core.CPU

class Top extends Module {
  val io = IO(new Bundle() {
    val cpu_debug_read_address = Input(UInt(Parameters.AddrWidth))
    val cpu_debug_read_data = Output(UInt(Parameters.DataWidth))

    val DataMemBundle = new RamAccessBundle
    val InstMemBundle = new RamAccessBundle

    val mem_read = Output(Bool())
  })

  val cpu = Module(new CPU)

  io.mem_read := cpu.io.mem_read
  cpu.io.reg_debug_read_address := io.cpu_debug_read_address
  io.cpu_debug_read_data := cpu.io.reg_debug_read_data

  val index = cpu.io.DataMemBundle.address(Parameters.AddrBits - 1, Parameters.AddrBits - 3)

  when(index =/= 0.U){
    io.DataMemBundle.address := 0.U
    io.InstMemBundle.address := 0.U
  }
  io.DataMemBundle <> cpu.io.DataMemBundle
  io.InstMemBundle <> cpu.io.InstMemBundle
}

object VerilogGenerator extends App {
  (new ChiselStage).execute(Array("-X", "verilog", "-td", "verilog/verilator"), Seq(ChiselGeneratorAnnotation(() =>
    new Top())))
}