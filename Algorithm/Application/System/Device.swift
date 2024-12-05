//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

enum DeviceID: Sendable, Codable, CustomStringConvertible {
  case uuid(UUID)
  case mac(MACAddress)

  var description: String {
    return switch self {
    case .uuid(let uuid):
      uuid.description
    case .mac(let mac):
      mac.description
    }
  }
}

struct Device {
  var name: String

  var systemName: String
  var systemVersion: String

  var model: String

  var id: DeviceID
}
