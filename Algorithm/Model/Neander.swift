// Copyright © 2023 Kenneth Laskoski
// SPDX-License-Identifier: Apache-2.0

import SwiftUI

class Neander: ObservableObject {
  typealias Word = UInt8
  static let memSize = (Word.min...Word.max).count

  static let bitPattern = UInt(~Word.zero)
  static let bitMask = Int(bitPattern: bitPattern)

  struct Flag: Identifiable {
    let name: String
    let isOn: Bool

    var id: String { name }
  }

  class State: ObservableObject {
    enum RunState {
      case stopped
      case running
    }

    @Published
    var memory = [Int](repeating: 0, count: Neander.memSize)

    var rMemAddr = 0
    var rMemData = 0

    @Published
    var rAC = 0
    var zeroFlag: Flag { Flag(name: "Z", isOn: rAC == 0) }
    var negativeFlag: Flag { Flag(name: "N", isOn: rAC > 0x7f) }

    @Published
    var rPC = 0
    var rI = 0

    var runState: RunState = .stopped
  }

  @Published
  var state = State()

  typealias Transition = (Neander) -> ()

  static let memRead: Transition = {
    var state = $0.state
    state.rMemData = state.memory[state.rMemAddr]
  }

  static let memWrite: Transition = {
    var state = $0.state
    state.memory[state.rMemAddr] = state.rMemData
  }

  static let fetch: Transition = {
    var state = $0.state
    state.rMemAddr = state.rPC
    state.rPC += 1
    state.rPC &= bitMask
  }

  static let decode: Transition = {
    memRead($0)
    var state = $0.state
    state.rI = state.rMemData
  }

  static let fetchOperand: Transition = {
    var state = $0.state
    let opCode = state.rI & 0b1111_0000
    switch opCode {
    case 0b0000_0000, 0b0110_0000, 0b1111_0000:
      break
    default:
      fetch($0)
      memRead($0)
      state.rMemAddr = state.rMemData
      memRead($0)
    }
  }

  static let execute: Transition = {
    var state = $0.state
    let opCode = state.rI & 0b1111_0000
    switch opCode {
    case 0b0001_0000:
      state.rMemData = state.rAC
      memWrite($0)
    case 0b0010_0000, 0b0011_0000, 0b0100_0000, 0b0101_0000, 0b0110_0000:
      ula($0)
    case 0b1000_0000, 0b1001_0000, 0b1010_0000:
      jmp($0)
    case 0b1111_0000:
      state.runState = .stopped
    default:
      break
    }
  }

  static let ula: Transition = {
    var state = $0.state
    let opCode = state.rI & 0b1111_0000
    switch opCode {
    case 0b0010_0000:
      state.rAC = state.rMemData
    case 0b0011_0000:
      state.rAC += state.rMemData
    case 0b0100_0000:
      state.rAC |= state.rMemData
    case 0b0101_0000:
      state.rAC &= state.rMemData
    case 0b0110_0000:
      state.rAC = ~state.rAC
    default:
      break
    }
    state.rAC &= bitMask
  }

  static let jmp: Transition = {
    var state = $0.state
    let opCode = state.rI & 0b1111_0000
    switch opCode {
    case 0b1000_0000:
      state.rPC = state.rMemData
    case 0b1001_0000:
      if state.negativeFlag.isOn {
        state.rPC = state.rMemData
      }
    case 0b1010_0000:
      if state.zeroFlag.isOn {
        state.rPC = state.rMemData
      }
    default:
      break
    }
    state.rPC &= bitMask
  }

  static let cycle: Transition = {
    fetch($0)
    decode($0)
    fetchOperand($0)
    execute($0)
  }

  func run() {
    state.runState = .running
    while state.runState == .running && state.rPC < 0x80 {
      Neander.cycle(self)
    }
    state.runState = .stopped
  }
}