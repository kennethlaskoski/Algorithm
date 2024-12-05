//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

protocol Register: Identifiable {
  associatedtype State: FixedWidthInteger

  var id: String { get }
  var state: State { get set }
}

extension Register {
  var name: String { id }
}

protocol Flag: Identifiable {
  var id: String { get }
  var isOn: Bool { get set }
}

extension Flag {
  var name: String { id }
}

protocol MemoryType: RandomAccessCollection {
  var rAddr: Index { get set }
  var rData: Element { get set }

  mutating func read()
  mutating func write()
}
