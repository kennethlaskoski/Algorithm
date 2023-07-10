//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ContentView: View {
  var body: some View {
    NeanderView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var machine = Neander()
  static var previews: some View {
    ContentView()
      .environmentObject(machine)
  }
}
