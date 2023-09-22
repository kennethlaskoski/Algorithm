//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

/// An Operating System.
///
/// Values mirror os() compilation conditions in Swift 5.9 (as listed in the
/// [Swift book](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements#Conditional-Compilation-Block)
/// on 2023-09-21).
enum OperatingSystem: String, CaseIterable {
  case iOS
  case tvOS
  case macOS
  case watchOS
  case visionOS

  case Linux
  case Windows
  case FreeBSD
}

extension OperatingSystem: Sendable, Codable {}

extension OperatingSystem: Identifiable {
  var id: String { rawValue }
}

extension OperatingSystem: CustomStringConvertible {
  var description: String { rawValue }
}

extension Device {
  /// The operating system running on the device.
#if os(iOS)
  var operatingSystem: OperatingSystem { .iOS }
#endif

#if os(tvOS)
  var operatingSystem: OperatingSystem { .tvOS }
#endif

#if os(macOS)
  var operatingSystem: OperatingSystem { .macOS }
#endif

#if os(watchOS)
  var operatingSystem: OperatingSystem { .watchOS }
#endif

#if os(visionOS)
  var operatingSystem: OperatingSystem { .visionOS }
#endif

#if os(Linux)
  var operatingSystem: OperatingSystem { .Linux }
#endif

#if os(Windows)
  var operatingSystem: OperatingSystem { .Windows }
#endif

#if os(FreeBSD)
  var operatingSystem: OperatingSystem { .FreeBSD }
#endif
}
