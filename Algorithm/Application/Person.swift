//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Person: Sendable, Codable {
  let nameComponents: PersonNameComponents

  var name: String { nameComponents.formatted() }
  var nickname: String? { nameComponents.nickname }
  var monogram: String { nameComponents.formatted(.name(style: .abbreviated)) }
}

extension Person {
  static let placeholder = Person(nameComponents: PersonNameComponents(givenName: "Place", familyName: "Holder"))
}
