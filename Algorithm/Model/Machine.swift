//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

protocol Register: Identifiable {
  associatedtype Value: FixedWidthInteger

  var name: String { get }
  var value: Value { get set }
}

extension Register {
  var id: String { name }
}

protocol Flag: Identifiable {
  var name: String { get }
  var isOn: Bool { get set }
}

extension Flag {
  var id: String { name }
}

protocol Memory: RandomAccessCollection {
  associatedtype Address: Register
  associatedtype Data: Register

  var rAddress: Address { get set }
  var rData: Data { get set }

  func read()
  func write()
}
