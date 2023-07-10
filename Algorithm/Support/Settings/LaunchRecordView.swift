//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct LaunchRecordView: View {
  @EnvironmentObject var launchRecord: LaunchRecord

  var body: some View {
    List(launchRecord.launches) {
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

struct LaunchRecordView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchRecordView()
      .environmentObject(LaunchRecord())
  }
}
