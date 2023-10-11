//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

// MARK: - Operating System
/// An operating system is the set of sotware components with direct access hardware resources, providing services 
/// software resources, and provides services for applications to access them.
enum OperatingSystem: String {
  case iOS
  case tvOS
  case macOS
  case watchOS
  case visionOS

  case Linux
  case Windows

  // Undocumented
  case Android
  case OpenBSD
  case FreeBSD
}

/// The operating system's name
extension OperatingSystem {
  var name: String { rawValue }
}

// MARK: - Machine Architecture
/// An architecture models hardware elements and defines their
/// resulting state as a device executes programed instructions.
enum MachineArchitecture: String {
  case arm
  case i386
  case arm64
  case x86_64
}

/// The name of the architecture
extension MachineArchitecture {
  var name: String { rawValue }
}

// MARK: - Platform
/// A platform define the environment in which the application is executed
struct Platform {
  let operatingSystem: OperatingSystem
  let machineArchitecture: MachineArchitecture
}
