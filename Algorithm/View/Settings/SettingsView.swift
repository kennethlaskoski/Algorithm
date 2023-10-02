//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject private var appDelegate: ApplicationDelegate

  private enum Tabs: Hashable {
    case systemInfo
    case launches
    case boot
  }

  var body: some View {
    TabView {
      SystemInfoView()
        .tabItem {
          Label("System Info", systemImage: "info.circle")
        }
        .tag(Tabs.systemInfo)
      LaunchesView()
        .tabItem {
          Label("Launches", systemImage: "list.bullet.circle")
        }
        .tag(Tabs.launches)
      BootView()
        .tabItem {
          Label("Boot", systemImage: "power.circle")
        }
        .tag(Tabs.boot)
    }
    .padding(20)
    .frame(width: 800.0, height: 600.0)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
    .environmentObject(ApplicationDelegate())
  }
}
