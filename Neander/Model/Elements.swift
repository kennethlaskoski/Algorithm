//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

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

protocol MemoryType: RandomAccessCollection {
  var rAddr: Index { get set }
  var rData: Element { get set }

  mutating func read()
  mutating func write()
}
