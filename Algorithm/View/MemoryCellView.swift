//  Copyright © 2024 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct MemCellView<T: FixedWidthInteger>: View {
  @Binding var value: T
  let isHexa: Bool

  var body: some View {
    Text(
      isHexa ?
      String(hexa: value, length: 2) :
      String(Int8(bitPattern: UInt8(value)))
    )
  }
}

