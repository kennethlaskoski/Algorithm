//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

struct Default<T> {
  let key: String
  let defaultValue: T

  let getter: () -> T
  let setter: (T) -> Void

  var value: T {
    get { getter() }
  }

  func set(newValue: T) { setter(newValue) }
}

struct Defaults {
  private let logger = Logger(subsystem: "br.net.ken.algorithm", category: "Defaults")

  var defaults: [Default<Any>]

  private var defaultDefaults: [String: Any] {
    var result: [String: Any] = [:]
    for item in defaults {
      result[item.key] = item.defaultValue
    }
    return result
  }

  func register() {
    logger.trace("Registering user defaults: \(defaultDefaults)")
    UserDefaults.standard.register(defaults: defaultDefaults)
  }
}
