//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var machine: Neander

  var body: some View {
    VStack {
      NeanderView()
      Spacer()
      ControlPanel(machine: machine)
    }
    .padding(.bottom, 8.0)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var machine = Neander()
  static var previews: some View {
    ContentView()
      .environmentObject(machine)
  }
}
