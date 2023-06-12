//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

@main
struct AlgorithmApp: App {
  @StateObject private var machine: Neander = {
    let neander = Neander()

    // .text
    neander.state.memory[0x00] = 0x20
    neander.state.memory[0x01] = 0x80
    neander.state.memory[0x02] = 0x30
    neander.state.memory[0x03] = 0x81
    neander.state.memory[0x04] = 0x10
    neander.state.memory[0x05] = 0x82
    neander.state.memory[0x06] = 0xF0

    // .data
    neander.state.memory[0x80] = 19
    neander.state.memory[0x81] = 23

    return neander
  }()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(machine)
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
