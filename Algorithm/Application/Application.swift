//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

extension Application {
  private static let info = ProcessInfo.processInfo

  static var processName: String { info.processName }
  static var processIdentifier: Int32 { info.processIdentifier }

#if !os(iOS) && !os(visionOS)
  static var login: String { info.userName }
  static var name: String { info.fullUserName }
#else

#endif
}

extension String {
  static let empty = String()
}
