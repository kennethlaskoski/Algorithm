//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

enum Device: Sendable, Codable {
  case tv
  case watch
  case vision
  case iPhone(UUID)
  case iPad(UUID)
  case mac(MAC)
  case pc
}

typealias MAC = Data
extension MAC {
  static var empty: MAC { MAC() }
}

#if canImport(UIKit)
import UIKit

extension Application {
  static var device: Device { .iPhone(UIDevice.current.identifierForVendor ?? .null) }
}
#endif

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

func copy_mac_address() -> MAC {
  // Prefer built-in network interfaces.
  // For example, an external Ethernet adaptor can displace
  // the built-in Wi-Fi as en0.
  guard let service = io_service(named: "en0", wantBuiltIn: true)
          ?? io_service(named: "en1", wantBuiltIn: true)
          ?? io_service(named: "en0", wantBuiltIn: false)
  else { return .empty }
  defer { IOObjectRelease(service) }

  if let cftype = IORegistryEntrySearchCFProperty(
    service,
    kIOServicePlane,
    "IOMACAddress" as CFString,
    kCFAllocatorDefault,
    IOOptionBits(kIORegistryIterateRecursively | kIORegistryIterateParents)
  ) {
    return Data(referencing: cftype as! CFData)
  }
  return .empty
}

extension Application {
  static var device: Device { .mac(copy_mac_address()) }
}
#endif
