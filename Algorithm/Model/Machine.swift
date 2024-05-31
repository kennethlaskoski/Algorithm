//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

protocol Machine: ObservableObject {
  func run()
  func halt()
  func step()
  func reset()
}
