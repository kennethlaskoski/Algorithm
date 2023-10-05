//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

// MARK: - Target Platform
private struct TargetPlatform: EnvironmentKey {
  static let defaultValue = Application.targetPlatform
}

extension EnvironmentValues {
  var targetPlatform: Platform {
    self[TargetPlatform.self]
  }
}

// MARK: - Process
private struct ProcessName: EnvironmentKey {
  static let defaultValue = Application.processName
}

extension EnvironmentValues {
  var processName: String {
    self[ProcessName.self]
  }
}

// MARK: - User
private struct ProcessIdentifier: EnvironmentKey {
  static let defaultValue = Application.processIdentifier
}

extension EnvironmentValues {
  var processIdentifier:  Int32 {
    self[ProcessIdentifier.self]
  }
}

