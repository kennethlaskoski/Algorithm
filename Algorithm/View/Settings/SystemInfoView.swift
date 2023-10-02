//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct SystemInfoView: View {
  @Environment(\.buildTimeOS) var buildTimeOS
  @Environment(\.processName) var processName
  @Environment(\.user) var user

  var body: some View {
    VStack {
      HStack {
        Text("Built for:")
        Text(buildTimeOS.name)
      }
      HStack {
        Text("Process:")
        Text(processName)
      }
      HStack {
        Text("User:")
        Text(user)
      }
    }
    .padding()
  }
}

struct SystemInfoView_Previews: PreviewProvider {
  static var previews: some View {
    SystemInfoView()
  }
}
