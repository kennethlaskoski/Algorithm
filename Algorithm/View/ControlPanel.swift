//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ControlPanel: View {
  let machine: Machine

  var body: some View {
    HStack {
      Button(action: { machine.run() }) {
        Label("Run", systemImage: "play.fill")
      }
      Button(action: { machine.halt() }) {
        Label("Stop", systemImage: "stop.fill")
      }
      Button(action: { machine.step() }) {
        Label("Step", systemImage: "forward.frame.fill")
      }
      Button(action: { machine.reset() }) {
        Label("Reset", systemImage: "backward.end.fill")
      }
    }
  }
}

let machine = Neander()

#Preview {
    ControlPanel(machine: machine)
}
