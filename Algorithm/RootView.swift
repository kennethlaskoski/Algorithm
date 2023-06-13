//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct RootView: View {
  var body: some View {
    NeanderView()
  }
}

struct RootView_Previews: PreviewProvider {
  static var machine = Neander()
  static var previews: some View {
    RootView()
      .environmentObject(machine)
  }
}
