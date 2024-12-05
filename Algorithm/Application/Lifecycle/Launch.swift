//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Launch: Sendable, Codable {
  let date: Date
  var deviceID: DeviceID

  init(at date: Date = .now, on deviceID: DeviceID = Application.device.id) {
    self.date = date
    self.deviceID = deviceID
  }
}

func finishLaunching() {
}
