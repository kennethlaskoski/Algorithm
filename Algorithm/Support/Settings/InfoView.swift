//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct InfoView: View {
  @EnvironmentObject var appData: AppData

  var body: some View {
    List(appData.launches) {
      run in
      VStack {
        HStack {
          Text("\(run.date.formatted(date: .abbreviated, time: .shortened))")
          Spacer()
        }
        Text("\(run.id)")
      }
      .font(.footnote)
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
      .environmentObject(AppData())
  }
}
