//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct LaunchesView: View {
  @EnvironmentObject private var appDelegate: Application.Delegate

  var body: some View {
    List(appDelegate.launchHistory) {
      record in
      HStack {
        Text("\(record.launch.date.formatted(date: .abbreviated, time: .shortened))")
        Spacer()
        Text("\(record.id)")
      }
      .font(.footnote)
    }
  }
}

struct LaunchesView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchesView()
    .environmentObject(Application.Delegate())
  }
}
