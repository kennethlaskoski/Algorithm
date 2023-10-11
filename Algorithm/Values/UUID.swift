//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

extension UUID {
  static let null = UUID(uuid: UUID_NULL)
  var isNull: Bool { self == .null }
}
