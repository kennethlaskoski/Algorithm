//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct AlgorithmApp: App {
  private var neander = Neander()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(neander.state)
    }
  }
}

struct deviceKey: EnvironmentKey {
  static var defaultValue = Device()
}

extension EnvironmentValues {
    var device: Device {
        get { self[deviceKey.self] }
        set { self[deviceKey.self] = newValue }
    }
}
