//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      BootView()
        .tabItem {
          Label("App", systemImage: "app.badge.checkmark")
        }
      InfoView()
        .tabItem {
          Label("Source", systemImage: "app.dashed")
        }
      InfoView()
        .tabItem {
          Label("Info", systemImage: "questionmark.app")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
