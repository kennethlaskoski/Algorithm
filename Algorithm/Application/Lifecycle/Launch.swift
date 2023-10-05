//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

struct Launch: Sendable, Codable {
  let date: Date
  var device: Device

  init(at date: Date = .now, on device: Device = Application.device) {
    self.date = date
    self.device = device
  }
}

func finishLaunching() {
}
