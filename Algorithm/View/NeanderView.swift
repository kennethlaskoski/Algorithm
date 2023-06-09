//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct NeanderView: View {
  @EnvironmentObject var state: Neander.State

  var body: some View {
    VStack {
      List {
        ForEach(0..<256, id: \.self) {
          Text(state.memory[$0].description)
        }
      }

      PCView(state: state)
      ACView(state: state)
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

      Spacer()

      Text(state.zeroFlag.name)
      BitView(isOn: Binding.constant(state.zeroFlag.isOn))
      BitView(isOn: Binding.constant(state.negativeFlag.isOn))
      Text(state.negativeFlag.name)
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
//    neander.state.rPC = 0x80
    return neander
  }()

  static var previews: some View {
    NeanderView()
      .environmentObject(neander.state)
  }
}
