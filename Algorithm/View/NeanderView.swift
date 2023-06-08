//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct NeanderView: View {
  @EnvironmentObject var state: Neander.State

  var body: some View {
    VStack {
      HStack {
        RegisterView(name: "AC", value: state.rAC)
        VStack {
          BitView(name: "Z", set: state.isZero)
          BitView(name: "N", set: state.isNegative)
        }
      }
      RegisterView(name: "PC", value: state.rPC)
    }
    .padding()
  }
}

struct RegisterView: View {
  let name: String
  let value: Int

  var body: some View {
    HStack {
      Text(name)
      Text("\(value)")
    }
    .padding()
  }
}

struct BitView: View {
  let name: String
  let set: Bool

  var body: some View {
    HStack {
      Text(name)
      Image(systemName: set ? "circle.fill" : "circle")
        .foregroundColor(.accentColor)
    }
  }
}

struct NeanderView_Previews: PreviewProvider {
  static var previews: some View {
    NeanderView()
      .environmentObject(Neander().state)
  }
}
