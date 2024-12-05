//  Copyright © 2024 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

#if canImport(UIKit)
import UIKit

extension Application {
  static var device: Device {
    let device = UIDevice.current
    return Device(
      name: device.name,
      systemName: device.systemName,
      systemVersion: device.systemVersion,
      model: device.model,
      id: .uuid(device.identifierForVendor ?? .null)
    )
  }
}
#endif
