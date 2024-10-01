//
//  ControlMenu.swift
//  Algorithm
//
//  Created by Kenneth Laskoski on 2024-05-03.
//

import SwiftUI

struct ControlMenu<Machine: MachineViewModel>: View {
  var body: some View {
    Menu {
//      ControlPanel<Machine>()
    } label: {
      Label("Run", systemImage: "play.fill")
    }
  }
}

#Preview {
    ControlMenu<Neander>()
}
