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

package riscv.core

import chisel3._
import peripheral.RamAccessBundle
import riscv.Parameters

class CPU extends Module {
  val io = IO(new Bundle {
    val DataMemBundle = new RamAccessBundle
    val InstMemBundle = new RamAccessBundle
    val reg_debug_read_address = Input(UInt(Parameters.AddrWidth))
    val reg_debug_read_data = Output(UInt(Parameters.DataWidth))
  })

  val regs = Module(new RegisterFile)
  val inst_fetch = Module(new InstructionFetch)
  val id = Module(new InstructionDecode)
  val ex = Module(new Execute)
  val mem = Module(new MemoryAccess)
  val wb = Module(new WriteBack)

  inst_fetch.io.jump_address_id := id.io.if_jump_address
  inst_fetch.io.jump_flag_id := id.io.if_jump_flag

  io.DataMemBundle <> mem.io.bundle
  io.InstMemBundle <> inst_fetch.io.bundle

  regs.io.write_enable := id.io.ex_reg_write_enable
  regs.io.write_address := id.io.ex_reg_write_address
  regs.io.write_data := wb.io.regs_write_data
  regs.io.read_address1 := id.io.regs_reg1_read_address
  regs.io.read_address2 := id.io.regs_reg2_read_address

  regs.io.debug_read_address := io.reg_debug_read_address
  io.reg_debug_read_data := regs.io.debug_read_data

  id.io.reg1_data := regs.io.read_data1
  id.io.reg2_data := regs.io.read_data2
  id.io.instruction := inst_fetch.io.id_instruction
  id.io.instruction_address := inst_fetch.io.id_instruction_address

  ex.io.instruction := inst_fetch.io.id_instruction
  ex.io.instruction_address := inst_fetch.io.id_instruction_address
  ex.io.reg1_data := regs.io.read_data1
  ex.io.reg2_data := regs.io.read_data2
  ex.io.immediate := id.io.ex_immediate
  ex.io.aluop1_source := id.io.ex_aluop1_source
  ex.io.aluop2_source := id.io.ex_aluop2_source

  mem.io.alu_result := ex.io.mem_alu_result
  mem.io.reg2_data := ex.io.reg2_data
  mem.io.memory_read_enable := id.io.ex_memory_read_enable
  mem.io.memory_write_enable := id.io.ex_memory_write_enable
  mem.io.funct3 := inst_fetch.io.id_instruction(14, 12)

  wb.io.instruction_address := inst_fetch.io.id_instruction_address
  wb.io.alu_result := ex.io.mem_alu_result
  wb.io.memory_read_data := mem.io.wb_memory_read_data
  wb.io.regs_write_source := id.io.ex_reg_write_source
}
