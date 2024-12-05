//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct AppInfo: View {
  @Environment(\.targetPlatform) var targetPlatform
  @Environment(\.device) var device
  @Environment(\.processName) var processName
  @Environment(\.processIdentifier) var processIdentifier

  var body: some View {
    VStack {
      Text("Target platform")
      HStack {
        Text("OS:")
        Text(targetPlatform.operatingSystem.name)
      }
      HStack {
        Text("Architecture:")
        Text(targetPlatform.machineArchitecture.name)
      }
      Spacer()
      Text("Device")
      HStack {
        Text("Name:")
        Text(device.name)
      }
      HStack {
        Text("System:")
        Text(device.systemName)
      }
      HStack {
        Text("Version:")
        Text(device.systemVersion)
      }
      HStack {
        Text("Model:")
        Text(device.model)
      }
      HStack {
        Text("ID:")
        Text(device.id.description).lineLimit(1)
      }
      Spacer()
      Text("Process")
      HStack {
        Text("Name:")
        Text(processName)
      }
      HStack {
        Text("ID:")
        Text(processIdentifier.description)
      }
    }
    .padding()
  }
}

struct AppInfo_Previews: PreviewProvider {
  static var previews: some View {
    AppInfo()
  }
}
