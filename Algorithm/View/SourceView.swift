//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct SourceView: View {
  var body: some View {
    Text(
"""
  VStack {
    Image(systemName: "globe")
      .imageScale(.large)
      .foregroundColor(.accentColor)
    Text("Hello, world!")
  }
  .padding()
"""
    )
    .font(.system(.footnote, design: .monospaced))
  }
}

struct SourceView_Previews: PreviewProvider {
  static var previews: some View {
    SourceView()
  }
}
