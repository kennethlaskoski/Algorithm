//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import DeviceCheck

extension Data {
  static let empty = Data()
}

struct Device: Sendable, Codable {
  typealias Token = Data

  enum ID: Sendable, Codable {
    case uuid(UUID)
    case mac(Data)
  }

  var id: ID

  init() {
    var id = ID.uuid(.null)

#if canImport(UIKit)
    id = .uuid(iDeviceID())
#endif

#if canImport(AppKit)
    id = macDeviceID()
#endif

    self.id = id
  }

  var supportsCheck: Bool { DCDevice.current.isSupported }
  var token: Token {
    get async throws { try await DCDevice.current.generateToken() }
  }
}

extension Device {
  static let unknown = Device()
}

#if canImport(IOKit)
import IOKit

// Returns an object with a +1 retain count; the caller needs to release.
func io_service(named name: String, wantBuiltIn: Bool) -> io_service_t? {
  let default_port = kIOMainPortDefault

  var iterator = io_iterator_t()
  defer {
    if iterator != IO_OBJECT_NULL {
      IOObjectRelease(iterator)
    }
  }

  guard
    let matchingDict = IOBSDNameMatching(default_port, 0, name),
    IOServiceGetMatchingServices(default_port, matchingDict as CFDictionary, &iterator) == KERN_SUCCESS,
    iterator != IO_OBJECT_NULL
  else { return nil }

  var candidate = IOIteratorNext(iterator)
  while candidate != IO_OBJECT_NULL {
    if let cftype = IORegistryEntryCreateCFProperty(candidate, "IOBuiltin" as CFString, kCFAllocatorDefault, 0) {
      let isBuiltIn = cftype.takeRetainedValue() as! CFBoolean
      if wantBuiltIn == CFBooleanGetValue(isBuiltIn) {
        return candidate
      }
    }

    IOObjectRelease(candidate)
    candidate = IOIteratorNext(iterator)
  }

  return nil
}

func copy_mac_address() -> CFData? {
  // Prefer built-in network interfaces.
  // For example, an external Ethernet adaptor can displace
  // the built-in Wi-Fi as en0.
  guard let service = io_service(named: "en0", wantBuiltIn: true)
          ?? io_service(named: "en1", wantBuiltIn: true)
          ?? io_service(named: "en0", wantBuiltIn: false)
  else { return nil }
  defer { IOObjectRelease(service) }

  if let cftype = IORegistryEntrySearchCFProperty(
    service,
    kIOServicePlane,
    "IOMACAddress" as CFString,
    kCFAllocatorDefault,
    IOOptionBits(kIORegistryIterateRecursively | kIORegistryIterateParents)) {
    return (cftype as! CFData)
  }

  return nil
}
#endif

#if canImport(AppKit)
func macDeviceID() -> Device.ID {
  guard let cfData = copy_mac_address() else { return .mac(.empty) }
  return .mac(Data(referencing: cfData))
}
#endif

#if canImport(UIKit)
import UIKit

func iDeviceID() -> UUID {
  return UIDevice.current.identifierForVendor ?? .null
}
#endif
