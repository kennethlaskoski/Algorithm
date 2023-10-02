//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

struct Launch: Sendable, Codable {
  let date: Date
  var person: Person
  var device: Device

  init(at date: Date = .now, by person: Person = .placeholder, on device: Device = .unknown) {
    self.date = date
    self.person = person
    self.device = device
  }
}

func finishLaunching() {

}
