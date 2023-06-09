//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct NeanderView: View {
  @EnvironmentObject var state: Neander.State

  var body: some View {
    Grid {
      GridRow(alignment: .bottom) {
        RegisterView(name: "AC", value: state.rAC)
        FlagGrid([
          state.zeroFlag,
          state.negativeFlag,
        ])
        .padding([.horizontal], 4.0)
        .padding([.vertical], 2.0)
        .border(Color.accentColor)
      }
      GridRow {
        RegisterView(name: "PC", value: state.rPC)
      }
    }
//    .padding()
  }
}

struct RegisterView: View {
  let name: String
  let value: Int

  var body: some View {
    VStack {
      HStack {
        Text(name)
        Text("\(value)")
      }
      BinaryView(Int8(value))
    }
  }
}

struct FlagGrid: View {
  private let flags: [Flag]

  init(_ flags: [Flag]) {
    self.flags = flags
  }

  var body: some View {
    Grid(horizontalSpacing: 1.0) {
      ForEach(flags) { flag in
        GridRow {
          Text(flag.name)
            .font(.footnote)
          BitView(isOn: flag.isOn)
        }
      }
    }
  }
}

struct BitView: View {
  let isOn: Bool
  var body: some View {
      Image(systemName: isOn ? "circle.inset.filled" : "circle")
        .foregroundColor(.accentColor)
  }
}

struct BinaryView<T: FixedWidthInteger>: View {
  private let digits = T.bitWidth

  let value: T
  let bits: [Flag]

  init(_ value: T) {
    self.value = value
    var bits = [Flag]()
    var mask: T
    for bit in (0..<digits).reversed() {
      mask = 1 << bit
      bits.append(Flag(name: "\(bit)", isOn: value & mask != 0))
    }
    self.bits = bits
  }

  var body: some View {
    HStack(spacing: 0.0) {
      ForEach(bits) { bit in
        BitView(isOn: bit.isOn)
      }
    }
  }
}

struct NeanderView_Previews: PreviewProvider {
  static var neander: Neander = {
    let neander = Neander()
    neander.state.rAC = -1
    return neander
  }()

  static var previews: some View {
    NeanderView()
      .environmentObject(neander.state)
  }
}
