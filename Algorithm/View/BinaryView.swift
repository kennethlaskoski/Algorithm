//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

//protocol BitCollection: RawRepresentable, RandomAccessCollection
//where RawValue: FixedWidthInteger, Element == Bool, Index == Int {
//  static func mask(for bit: Int) -> RawValue
//}
//
//struct Bits<RawValue: FixedWidthInteger>: BitCollection {
//  static func mask(for bit: Int) -> RawValue { RawValue(1) << bit }
//
//  private(set) var rawValue: RawValue
//
//  let startIndex = 0
//  let endIndex = RawValue.bitWidth
//
//  subscript(_ bit: Int) -> Bool {
//    get { rawValue & Self.mask(for: bit) != 0 }
//    set {
//      if newValue {
//        rawValue |= Self.mask(for: bit)
//      } else {
//        rawValue &= ~Self.mask(for: bit)
//      }
//    }
//  }
//}
//

struct Bits<RawValue: FixedWidthInteger>: OptionSet {
  let rawValue: RawValue
  static subscript(_ bit: Int) -> Self {
    Self(rawValue: 1 << bit)
  }
}

extension FixedWidthInteger {
  var bits: Bits<Self> { Bits(rawValue: self) }
  subscript(_ bit: Int) -> Bool {
    get { bits.contains(Bits[bit]) }
    set {
      self = newValue ?
      bits.union(Bits[bit]).rawValue :
      bits.symmetricDifference(Bits[bit]).rawValue
    }
  }
}

struct BitView: View {
  @Binding var isOn: Bool

  var body: some View {
    Image(systemName: "circle.inset.filled")
      .foregroundStyle(
        isOn ? Color.accentColor : Color.accentColor.opacity(0.4),
        Color.accentColor
      )
      .onTapGesture {
        isOn.toggle()
      }
  }
}

struct BinaryView<T: FixedWidthInteger>: View {
  @Binding var number: T

  var body: some View {
    Grid {
      ForEach(0..<number.bitWidth / 8, id: \.self) { row in
        GridRow {
          HStack(spacing: 0.0) {
            ForEach((0..<8).reversed(), id: \.self) { column in
              BitView(
                isOn: Binding(
                  get: { number[row * 8 + column] },
                  set: { number[row * 8 + column] = $0 }
                )
              )
            }
          }
        }
      }
    }
  }
}

struct BinaryView_Previews: PreviewProvider {
  static let testValue: Int = 1 - 1 - 1

  static var previews: some View {
    BinaryView(number: Binding.constant(testValue))
  }
}
