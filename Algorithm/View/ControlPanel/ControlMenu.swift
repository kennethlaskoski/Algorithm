//
//  ControlMenu.swift
//  Algorithm
//
//  Created by Kenneth Laskoski on 2024-05-03.
//

import SwiftUI

struct ControlMenu<M: Machine>: View {
  var body: some View {
    Menu {
      ControlPanel<M>()
    } label: {
      Label("Run", systemImage: "play.fill")
    }
  }
}

#Preview {
    ControlMenu<Neander>()
}
