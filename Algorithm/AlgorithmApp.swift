//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct AlgorithmApp: App {
  private var appData = AppData()
  @StateObject private var machine = Neander()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(machine)
    }

    #if os(macOS)
    Settings {
      SettingsView()
        .environmentObject(appData)
    }
    #endif
  }
}
