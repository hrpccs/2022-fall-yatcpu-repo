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

package riscv.core.fivestage

import chisel3._
import chisel3.experimental.ChiselEnum
import chisel3.util._
import riscv.Parameters

object ALUFunctions extends ChiselEnum {
  val zero, add, sub, sll, slt, xor, or, and, srl, sra, sltu = Value
}

class ALU extends Module {
  val io = IO(new Bundle {
    val func = Input(ALUFunctions())

    val op1 = Input(UInt(Parameters.DataWidth))
    val op2 = Input(UInt(Parameters.DataWidth))

    val result = Output(UInt(Parameters.DataWidth))
  })

  io.result := MuxLookup(
    io.func,
    0.U,
    IndexedSeq(
      ALUFunctions.add -> (io.op1 + io.op2),
      ALUFunctions.sub -> (io.op1 - io.op2),
      ALUFunctions.sll -> (io.op1 << io.op2(4, 0)),
      ALUFunctions.slt -> (io.op1.asSInt < io.op2.asSInt),
      ALUFunctions.xor -> (io.op1 ^ io.op2),
      ALUFunctions.or -> (io.op1 | io.op2),
      ALUFunctions.and -> (io.op1 & io.op2),
      ALUFunctions.srl -> (io.op1 >> io.op2(4, 0)),
      ALUFunctions.sra -> (io.op1.asSInt >> io.op2(4, 0)).asUInt,
      ALUFunctions.sltu -> (io.op1 < io.op2),
    )
  )
}
