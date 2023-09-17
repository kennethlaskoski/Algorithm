//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct LaunchHistoryView: View {
  @EnvironmentObject private var appDelegate: ApplicationDelegate

  var body: some View {
    List(appDelegate.launchHistory) {
      record in
      VStack {
        HStack {
          Text("\(record.launch.date.formatted(date: .abbreviated, time: .shortened))")
          Spacer()
        }
        Text("\(record.id)")
      }
      .font(.footnote)
    }
  }
}

struct LaunchHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchHistoryView()
    .environmentObject(ApplicationDelegate())
  }
}
