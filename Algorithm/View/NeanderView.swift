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
  @StateObject var machine: Neander

  var body: some View {
    VStack {
      HStack(spacing: 0.0) {
        ScrollView {
          Grid(alignment: .leading) {
            ForEach(0..<Neander.memSize / 2 , id: \.self) { i in
              GridRow {
                Text(String(hexa: i, length: 2))
                Text("\(machine.state.memory[i])")

                Spacer()
              }
            }
          }
        }

        Divider()

        ScrollView {
          Grid(alignment: .leading) {
            ForEach(Neander.memSize / 2..<Neander.memSize, id: \.self) { i in
              GridRow {
                Text(String(hexa: i, length: 2))
                Text("\(machine.state.memory[i])")

                Spacer()
              }
            }
          }
        }.padding(.leading, 4.0)
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

struct ACView: View {
  @StateObject var state: Neander.State

  var body: some View {
    HStack(spacing: 0.0) {
      HStack(spacing: 4.0) {
        Text("AC")
        BinaryView(
          number: Binding(
            get: { state.rAC[0] },
            set: { state.rAC = Int($0) }
          )
        )
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
  @StateObject var state: Neander.State

  var body: some View {
    HStack(spacing: 0.0) {
      HStack(spacing: 4.0) {
        Text("PC")
        BinaryView(
          number: Binding(
            get: { state.rPC[0] },
            set: { state.rPC = Int($0) }
          )
        )
      }

      Spacer()
    }
  }
}

struct FlagsView: View {
  private let flags: [Flag]

  init(_ flags: [Flag]) {
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
  static var neander: Neander = {
    let neander = Neander()
//    neander.state.rAC = 0
//    neander.state.rPC = 0
    return neander
  }()

  static var previews: some View {
    NeanderView(machine: neander)
      .environmentObject(neander)
  }
}
