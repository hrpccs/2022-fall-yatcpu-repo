// Copyright 2022 Howard Lau
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
import threestage.{CPU => ThreeStageCPU}
import fivestage_stall.{CPU => FiveStageCPUStall}
import fivestage_forward.{CPU => FiveStageCPUForward}
import fivestage_final.{CPU => FiveStageCPUFinal}
import riscv.ImplementationType

class CPU(val implementation: Int = ImplementationType.FiveStageFinal) extends Module {
  val io = IO(new CPUBundle)
  implementation match {
    case ImplementationType.ThreeStage =>
      val cpu = Module(new ThreeStageCPU)
      cpu.io <> io
    case ImplementationType.FiveStageStall =>
      val cpu = Module(new FiveStageCPUStall)
      cpu.io <> io
    case ImplementationType.FiveStageForward =>
      val cpu = Module(new FiveStageCPUForward)
      cpu.io <> io
    case _ =>
      val cpu = Module(new FiveStageCPUFinal)
      cpu.io <> io
  }
}
