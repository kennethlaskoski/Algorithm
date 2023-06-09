//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct RootView: View {
  @EnvironmentObject var machine: Neander
  var body: some View {
    NeanderView(machine: machine)
  }
}

struct RootView_Previews: PreviewProvider {
  static var machine = Neander()
  static var previews: some View {
    RootView()
    .environmentObject(machine)
  }
}
