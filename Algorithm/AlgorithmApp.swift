//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct AlgorithmApp: App {
  private var appData = AppData()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appData)
    }
  }
}

struct deviceKey: EnvironmentKey {
  static var defaultValue = Device()
}

extension EnvironmentValues {
    var device: Device {
        get { self[deviceKey.self] }
//        set { self[deviceKey.self] = newValue }
    }
}
