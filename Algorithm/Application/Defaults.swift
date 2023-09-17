//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

struct Defaults {
  private static let logger = Logger(subsystem: "br.net.ken.algorithm.defaults", category: "Defaults")

  private static let lastLaunchIDKey = "lastLaunchID"
  private static let onboardingPhaseKey = "onboardingPhaseKey"

  private static let defaults: [String: Any] = [
    lastLaunchIDKey: UUID.null.uuidString,
    onboardingPhaseKey: 0,
  ]
}

fileprivate extension Defaults {
  static func register() {
    logger.trace("Registering user defaults: \(defaults)")
    UserDefaults.standard.register(defaults: defaults)
  }
}

func registerDefaults() {
  Defaults.register()
}

extension Defaults {
  static var lastLaunchID: UUID {
    get {
      // retrieve last launch ID string from user defaults
      guard let lastLaunchIDString = UserDefaults.standard.string(forKey: lastLaunchIDKey) else {
        logger.critical("Application will crash - error retrieving last launch ID string from user defaults.")
        fatalError("Failure reading user defaults")
      }
      logger.trace("User defaults for key \"\(lastLaunchIDKey)\": \(lastLaunchIDString)")

      // parse last launch ID string from user defaults
      guard let lastLaunchID = UUID(uuidString: lastLaunchIDString) else {
        logger.critical("Application will crash - error parsing last launch ID string from user defaults")
        fatalError("Failure reading user defaults")
      }
      logger.trace("Last launch ID: \(lastLaunchID)")

      return lastLaunchID
    }

    set {
      logger.trace("Writing launch ID to user defaults")
      UserDefaults.standard.set(newValue.uuidString, forKey: lastLaunchIDKey)
    }
  }
}
