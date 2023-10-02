//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Process {
  private static let info = ProcessInfo.processInfo

  static var pid: Int32 { info.processIdentifier }
  static var name: String { info.processName }

#if !os(iOS)
  static var user: String { info.userName }
  static var userName: String { info.fullUserName }
#else
  static var user: String { "placeholder" }
  static var userName: String { "Place Holder" }
#endif
}
