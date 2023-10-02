//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

enum OperatingSystem: String {//, Sendable, Codable, Equatable {
  case iOS
  case tvOS
  case macOS
  case watchOS
  case visionOS

  case Linux
  case Windows

  // Undocumented
  case FreeBSD
}

extension OperatingSystem {
  var name: String { rawValue }
}

extension OperatingSystem {
#if os(iOS)
  static let atBuildTime: OperatingSystem = .iOS
#endif

#if os(tvOS)
  static let atBuildTime: OperatingSystem = .tvOS
#endif

#if os(macOS)
  static let atBuildTime: OperatingSystem = .macOS
#endif

#if os(watchOS)
  static let atBuildTime: OperatingSystem = .watchOS
#endif

#if os(visionOS)
  static let atBuildTime: OperatingSystem = .visionOS
#endif

#if os(Linux)
  static let atBuildTime: OperatingSystem = .Linux
#endif

#if os(Windows)
  static let atBuildTime: OperatingSystem = .Windows
#endif

#if os(FreeBSD)
  static let atBuildTime: OperatingSystem = .FreeBSD
#endif
}
