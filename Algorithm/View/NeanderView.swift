//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

extension String {
  public init<T: FixedWidthInteger>(hexa: T, length: Int = T.bitWidth / 4) {
    let hexaString = String(hexa, radix: 16, uppercase: true)
    let padding = String(repeating: "0", count: length - hexaString.count)
    self = padding + hexaString
  }
}

struct NeanderView: View {
  @EnvironmentObject var machine: Neander

  var body: some View {
    VStack {
      HStack(spacing: 0.0) {
        ScrollView {
          Grid(alignment: .leading) {
            ForEach(machine.state.memory.startIndex...0x7F, id: \.self) { i in
              GridRow {
                Text(String(hexa: i, length: 2))
                MemCellView(value: $machine.state.memory[i], isHexa: true)

                Spacer()
              }
            }
          }
        }

        Divider()

        MemoryView(state: machine.state).padding(.leading, 4.0)

      }.fontDesign(.monospaced)

      HStack {
        VStack {
          PCView(state: machine.state)
          ACView(state: machine.state)
        }
        Button(action: { machine.run() }) {
          Label("", systemImage: "play.fill").font(.body)
        }
      }

    }
    .padding(.horizontal, 4.0)
    .font(.footnote)
  }
}

struct MemoryView: View {
  @ObservedObject var state: Neander.State

  var body: some View {
    ScrollView {
      Grid(alignment: .leading) {
        ForEach(Neander.Word(0x80)...0xFF, id: \.self) { i in
          GridRow {
            Text(String(hexa: i, length: 2))
            MemCellView(value: $state.memory[i], isHexa: false)

            Spacer()
          }
        }
      }
    }
  }
}

struct MemCellView<T: FixedWidthInteger>: View {
  @Binding var value: T
  let isHexa: Bool

  var body: some View {
    Text(
      isHexa ?
        String(hexa: value, length: 2) :
        String(Int8(bitPattern: UInt8(value)))
    )
  }
}

//struct MemCellView<T: FixedWidthInteger>: View {
//  @Binding var value: T
//  @State private var temporaryText: String
//  @FocusState private var isFocused: Bool
//  let isHexa: Bool
//
//  init() {
//    temporaryText = text(from: value)
//  }
//
//  var body: some View {
//    TextField(
//      "",
//      text: $temporaryText,
//      onCommit: { value = T(temporaryText, radix: isHexa ? 16 : 10) ??  value }
//    )
//    .focused($isFocused, equals: true)
//    .onTapGesture { isFocused = true }
//    .onExitCommand { temporaryText = text(from: value) }
//  }
//
//  func text(from value: T) -> String {
//    isHexa ?
//    String(hexa: value, length: 2) :
//    String(Int8(bitPattern: UInt8(value)))
//  }
//}

struct ACView: View {
  @ObservedObject var state: Neander.State

  var body: some View {
    HStack(spacing: 0.0) {
      HStack(spacing: 4.0) {
        Text("AC")
        BinaryView(number: $state.rAC)
      }
      HStack(spacing: 0.0) {
        Text(state.zeroFlag.name)
        BitView(isOn: Binding.constant(state.zeroFlag.isOn))
        BitView(isOn: Binding.constant(state.negativeFlag.isOn))
        Text(state.negativeFlag.name)
      }.padding(.leading, 8.0)

      Spacer()
    }
  }
}

struct PCView: View {
  @ObservedObject var state: Neander.State

  var body: some View {
    HStack(spacing: 0.0) {
      HStack(spacing: 4.0) {
        Text("PC")
        BinaryView(number: $state.rPC)
      }

      Spacer()
    }
  }
}

struct FlagsView: View {
  private let flags: [Neander.Flag]

  init(_ flags: [Neander.Flag]) {
    self.flags = flags
  }

  var body: some View {
      HStack(spacing: 0.0) {
        Text(flags[0].name)
          .font(.footnote)
        BitView(isOn: Binding.constant(flags[0].isOn))
        BitView(isOn: Binding.constant(flags[1].isOn))
        Text(flags[1].name)
          .font(.footnote)
    }
    .padding(.horizontal)
  }
}

struct NeanderView_Previews: PreviewProvider {
  static let machine: Neander = {
    let neander = Neander()

    // .text
    neander.state.memory[0x00] = 0x20
    neander.state.memory[0x01] = 0x80
    neander.state.memory[0x02] = 0x30
    neander.state.memory[0x03] = 0x81
    neander.state.memory[0x04] = 0x10
    neander.state.memory[0x05] = 0x82
    neander.state.memory[0x06] = 0xF0

    // .data
    neander.state.memory[0x80] = 19
    neander.state.memory[0x81] = 23

    return neander
  }()

  static var previews: some View {
    NeanderView()
      .environmentObject(machine)
  }
}
