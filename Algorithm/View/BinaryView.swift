//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

extension UInt8 {
  func mask(for bit: Int) -> Self { Self(1) << bit }

  subscript(_ bit: Int) -> Bool {
    get { (self & mask(for: bit)) != 0 }
    set {
      if newValue {
        self |= mask(for: bit)
      } else {
        self &= ~mask(for: bit)
      }
    }
  }
}

extension FixedWidthInteger {
  subscript(_ byte: Int) -> UInt8 {
    get { UInt8(truncatingIfNeeded: self >> (byte * 8)) }
    set {
      let clearMask = Self(UInt8.max) << (byte * 8)
      let setMask = Self(newValue) << (byte * 8)
      self &= ~clearMask
      self |= setMask
    }
  }
}

struct ByteView: View {
  @Binding var byte: UInt8

  var body: some View {
    HStack(spacing: 0.0) {
      ForEach((0..<byte.bitWidth).reversed(), id: \.self) { bit in
        BitView(
          isOn: Binding(
            get: { byte[bit] },
            set: { byte[bit] = $0 }
          )
        )
      }
    }
  }
}

struct BinaryView<T: FixedWidthInteger>: View {
  @Binding var number: T

  var body: some View {
    Grid {
      ForEach(0..<number.bitWidth / 8, id: \.self) { byte in
        GridRow {
          ByteView(
            byte: Binding(
              get: { number[byte] },
              set: { number[byte] = $0 }
            )
          )
        }
      }
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

struct BinaryView_Previews: PreviewProvider {
  static let testValue: Int = 1 - 1 //- 1

  static var previews: some View {
    BinaryView(number: Binding.constant(testValue))
  }
}
