//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ControlPanel<M: Machine>: View {
  var body: some View {
    HStack {
      RunButton<M>()
      StopButton<M>()
      StepButton<M>()
      ResetButton<M>()
    }
  }
}

struct RunButton<M: Machine>: View {
  @EnvironmentObject var machine: M

  var body: some View {
    Button(action: { machine.run() }) {
      Label("Run", systemImage: "play.fill")
    }
  }
}

struct StopButton<M: Machine>: View {
  @EnvironmentObject var machine: M

  var body: some View {
    Button(action: { machine.halt() }) {
      Label("Stop", systemImage: "stop.fill")
    }
  }
}

struct StepButton<M: Machine>: View {
  @EnvironmentObject var machine: M

  var body: some View {
    Button(action: { machine.step() }) {
      Label("Step", systemImage: "forward.frame.fill")
    }
  }
}

struct ResetButton<M: Machine>: View {
  @EnvironmentObject var machine: M

  var body: some View {
    Button(action: { machine.reset() }) {
      Label("Reset", systemImage: "backward.end.fill")
    }
  }
}

#Preview {
    ControlPanel<Neander>()
}
