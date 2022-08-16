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

class Control extends Module {
  val io = IO(new Bundle {
    val jump_flag = Input(Bool())

    val if_flush = Output(Bool())
    val id_flush = Output(Bool())
  })

  // Lab3(
  io.if_flush := io.jump_flag
  io.id_flush := io.jump_flag
}
