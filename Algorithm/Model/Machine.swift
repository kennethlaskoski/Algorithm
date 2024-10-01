//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

protocol Machine {
  func run()
  func halt()
  func step()
  func reset()
}

protocol MachineViewModel: Machine & ObservableObject {
  associatedtype MachineView: View
  var view: MachineView { get }
}
