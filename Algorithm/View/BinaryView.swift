//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct BitView: View {
  var isOn: Bool
  var body: some View {
    Image(systemName: "circle.inset.filled")
    .foregroundStyle(
      isOn ? Color.accentColor : Color.accentColor.opacity(0.4),
      Color.accentColor
    )
  }
}

struct BinaryView<T: FixedWidthInteger>: View {
  let number: T
  var body: some View {
    HStack(spacing: 0.0) {
      ForEach((0..<T.bitWidth).reversed(), id: \.self) { bit in
        BitView(isOn: number & (1 << bit) != 0)
      }
    }
  }
}

