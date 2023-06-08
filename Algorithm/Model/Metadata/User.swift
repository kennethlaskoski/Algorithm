//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct User: Identifiable, Codable {
  let id: UUID
  var nameComponents: PersonNameComponents

  var name: String { nameComponents.formatted() }
}
