//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

// MARK: - OS
private struct BuildTimeOS: EnvironmentKey {
  static let defaultValue = OperatingSystem.atBuildTime
}

extension EnvironmentValues {
  var buildTimeOS: OperatingSystem {
    self[BuildTimeOS.self]
  }
}

// MARK: - Process
private struct ProcessName: EnvironmentKey {
  static let defaultValue = Process.name
}

extension EnvironmentValues {
  var processName: String {
    self[ProcessName.self]
  }
}

// MARK: - User
private struct User: EnvironmentKey {
  static let defaultValue = Process.user
}

extension EnvironmentValues {
  var user: String {
    self[User.self]
  }
}
