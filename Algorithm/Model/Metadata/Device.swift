//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Device: Identifiable {
  let id: UUID
  var name: String

  init() {
    id = UUID()
    name = "New device"
  }
}
