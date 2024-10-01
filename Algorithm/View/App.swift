//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct Application: App {

#if canImport(AppKit)
  @NSApplicationDelegateAdaptor private var delegate: Delegate
#endif

#if canImport(UIKit)
  @UIApplicationDelegateAdaptor private var delegate: Delegate
#endif

  @StateObject private var machine = Neander()

  var body: some Scene {
    WindowGroup {
      ContentView<Neander>()
        .environmentObject(machine)
    }

    #if os(macOS)
    Settings {
      SettingsView()
    }
    #endif
  }
}
