//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct LaunchHistoryView: View {
  @EnvironmentObject private var appDelegate: ApplicationDelegate

  var body: some View {
    List(appDelegate.launches) {
      launch in
      VStack {
        HStack {
          Text("\(launch.date.formatted(date: .abbreviated, time: .shortened))")
          Spacer()
        }
        Text("\(launch.id)")
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
