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
import chisel3.util.MuxCase
import riscv.Parameters

object ProgramCounter {
  val EntryAddress = Parameters.EntryAddress
}

class InstructionFetch extends Module {
  val io = IO(new Bundle {
//    val stall_flag_ctrl = Input(Bool())
    val jump_flag_ctrl = Input(Bool())
    val jump_address_ctrl = Input(UInt(Parameters.AddrWidth))
    val rom_instruction = Input(UInt(Parameters.DataWidth))

    val rom_instruction_address = Output(UInt(Parameters.AddrWidth))
    val id_instruction_address = Output(UInt(Parameters.AddrWidth))
    val id_instruction = Output(UInt(Parameters.InstructionWidth))
//    val ctrl_stall_flag = Output(Bool())
  })
  val pc = RegInit(ProgramCounter.EntryAddress)
  val pending_jump = RegInit(false.B)

  pc := MuxCase(
    pc + 4.U,
    IndexedSeq(
      io.jump_flag_ctrl -> io.jump_address_ctrl,
//      (io.stall_flag_ctrl >= StallStates.PC) -> pc
    )
  )

  when(io.jump_flag_ctrl) {
    pending_jump := true.B
  }.otherwise {
    pending_jump := false.B
  }

  io.rom_instruction_address := pc
  io.id_instruction_address := pc
  io.id_instruction := Mux(!io.jump_flag_ctrl && !pending_jump, io.rom_instruction, InstructionsNop.nop)
//  io.ctrl_stall_flag := pending_jump
}
