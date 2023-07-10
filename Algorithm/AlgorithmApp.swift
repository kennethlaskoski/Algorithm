//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct AlgorithmApp: App {
  private var launchRecord = LaunchRecord()
  @StateObject private var machine = Neander()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(machine)
    }

    #if os(macOS)
    Settings {
      SettingsView()
        .environmentObject(launchRecord)
    }
    #endif
  }
}
