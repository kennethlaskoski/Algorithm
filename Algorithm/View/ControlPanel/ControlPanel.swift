//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

#if os(iOS)
fileprivate let placement: ToolbarItemPlacement = .bottomBar
#else
fileprivate let placement: ToolbarItemPlacement = .primaryAction
#endif

struct ControlPanel<Machine: MachineViewModel>: ToolbarContent {
  @EnvironmentObject var machine: Machine

  var body: some ToolbarContent {
    ToolbarItemGroup(placement: placement) {
      Spacer()
      Button(action: { machine.run() }) {
        Label("Run", systemImage: "play.fill")
      }
      Spacer()
      Button(action: { machine.halt() }) {
        Label("Stop", systemImage: "stop.fill")
      }
      Spacer()
      Button(action: { machine.step() }) {
        Label("Step", systemImage: "forward.frame.fill")
      }
      Spacer()
      Button(action: { machine.reset() }) {
        Label("Reset", systemImage: "backward.end.fill")
      }
      Spacer()
    }
  }
}
