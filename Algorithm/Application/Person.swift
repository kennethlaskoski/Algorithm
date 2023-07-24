//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Person: Identifiable, Codable {
  let id: UUID
  let nameComponents: PersonNameComponents
  var name: String { nameComponents.formatted() }
  var monogram: String { nameComponents.formatted(.name(style: .abbreviated)) }
}
