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

package riscv.core.threestage

import chisel3._
import riscv.Parameters

object StallStates {
  val None = 0.U
  val PC = 1.U
  val IF = 2.U
  val ID = 3.U
}

class Control extends Module {
  val io = IO(new Bundle {
    val jump_flag = Input(Bool())
    //    val stall_flag_if = Input(Bool())
    //    val stall_flag_id = Input(Bool())
    //    val stall_flag_ex = Input(Bool()) // no need to stall
    val stall_flag_clint = Input(Bool()) // store the cpu state at a time, no need to write csr separately
    val jump_address = Input(UInt(Parameters.AddrWidth))

    val pc_stall_flag = Output(Bool())//stall pc register
    val if_stall_flag = Output(Bool())//stall if2id register
    val id_stall_flag = Output(Bool())//stall id2ex register

    val pc_jump_flag = Output(Bool())
    val pc_jump_address = Output(UInt(Parameters.AddrWidth))
  })

  io.pc_jump_flag := io.jump_flag
  io.pc_jump_address := io.jump_address

  io.pc_stall_flag := false.B
  io.if_stall_flag := false.B
  io.id_stall_flag := io.stall_flag_clint  // when outer interrupt occur, stall signal rises up and we need to wait for the execution to be done (already guaranteed due to AsyncAssert state).
}
