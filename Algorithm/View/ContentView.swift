//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct ContentView<Machine: MachineViewModel>: View {
  @EnvironmentObject var machine: Machine
  
  var body: some View {
    machine.view
      .toolbar {
        ControlPanel<Machine>()
      }
  }
}

#Preview {
  ContentView<Neander>()
    .environmentObject(Neander())
}
