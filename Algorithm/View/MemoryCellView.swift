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

//struct MemCellView<T: FixedWidthInteger>: View {
//  @Binding var value: T
//  @State private var temporaryText: String
//  @FocusState private var isFocused: Bool
//  let isHexa: Bool
//
//  init() {
//    temporaryText = text(from: value)
//  }
//
//  var body: some View {
//    TextField(
//      "",
//      text: $temporaryText,
//      onCommit: { value = T(temporaryText, radix: isHexa ? 16 : 10) ??  value }
//    )
//    .focused($isFocused, equals: true)
//    .onTapGesture { isFocused = true }
//    .onExitCommand { temporaryText = text(from: value) }
//  }
//
//  func text(from value: T) -> String {
//    isHexa ?
//    String(hexa: value, length: 2) :
//    String(Int8(bitPattern: UInt8(value)))
//  }
//}
