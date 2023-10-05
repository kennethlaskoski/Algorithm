//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

private extension OperatingSystem {
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

private extension MachineArchitecture {
#if arch(arm)
  static let atBuildTime: MachineArchitecture = .arm
#endif

#if arch(i386)
  static let atBuildTime: MachineArchitecture = .i386
#endif

#if arch(arm64)
  static let atBuildTime: MachineArchitecture = .arm64
#endif

#if arch(x86_64)
  static let atBuildTime: MachineArchitecture = .x86_64
#endif
}

extension Application {
  static let targetPlatform = Platform(operatingSystem: .atBuildTime, machineArchitecture: .atBuildTime)
}
