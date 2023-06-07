//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appData: AppData

  var body: some View {
    if appData.isFirstRun {
      BootView()
    } else {
      TabView {
        AppView()
          .tabItem {
            Label("App", systemImage: "app")
          }
        SourceView()
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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppData())
  }
}
