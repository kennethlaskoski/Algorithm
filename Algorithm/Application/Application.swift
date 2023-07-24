//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct Application: App {
  @StateObject private var machine = Neander()

#if canImport(AppKit)
  @NSApplicationDelegateAdaptor private var appDelegate: ApplicationDelegate
#endif
#if canImport(UIKit)
  @UIApplicationDelegateAdaptor private var appDelegate: ApplicationDelegate
#endif

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(machine)
    }

    #if os(macOS)
    Settings {
      SettingsView()
    }
    #endif
  }
}
