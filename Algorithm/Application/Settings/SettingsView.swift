//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject private var appDelegate: ApplicationDelegate

  private enum Tabs: Hashable {
    case app
    case source
    case info
  }

  var body: some View {
    if appDelegate.isFirstLaunch {
      BootView()
    } else {
      TabView {
        AppView()
          .tabItem {
            Label("App", systemImage: "app")
          }
          .tag(Tabs.app)
        SourceView()
          .tabItem {
            Label("Source", systemImage: "app.dashed")
          }
          .tag(Tabs.source)
        LaunchHistoryView()
          .tabItem {
            Label("Info", systemImage: "questionmark.app")
          }
          .tag(Tabs.info)
      }
      .padding(20)
      .frame(width: 400.0, height: 300.0)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
    .environmentObject(ApplicationDelegate())
  }
}