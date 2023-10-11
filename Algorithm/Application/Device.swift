//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

enum Device: Sendable, Codable {
  case tv
  case watch
  case vision
  case iPhone(UUID)
  case iPad(UUID)
  case mac(MACAddress)
  case pc
}

#if canImport(UIKit)
import UIKit

extension Application {
  static var device: Device { .iPhone(UIDevice.current.identifierForVendor ?? .null) }
}
#endif

