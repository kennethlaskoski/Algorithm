//  Copyright © 2024 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

#if canImport(IOKit)
import IOKit

// Returns an object with a +1 retain count; the caller needs to release.
private func io_service(named name: String, wantBuiltIn: Bool) -> io_service_t? {
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

private func copy_mac_address() -> MACAddress {
  // Prefer built-in network interfaces.
  // For example, an external Ethernet adaptor can displace
  // the built-in Wi-Fi as en0.
  guard let service = io_service(named: "en0", wantBuiltIn: true)
          ?? io_service(named: "en1", wantBuiltIn: true)
          ?? io_service(named: "en0", wantBuiltIn: false)
  else { return .null }
  defer { IOObjectRelease(service) }

  if let cftype = IORegistryEntrySearchCFProperty(
    service,
    kIOServicePlane,
    "IOMACAddress" as CFString,
    kCFAllocatorDefault,
    IOOptionBits(kIORegistryIterateRecursively | kIORegistryIterateParents)
  ) {
    return MACAddress(bytes: Data(referencing: cftype as! CFData))
  }
  return .null
}

func model() -> String {
  var size = 0
  sysctlbyname("hw.model", nil, &size, nil, 0)

  var modelIdentifier: [CChar] = Array(repeating: 0, count: size)
  sysctlbyname("hw.model", &modelIdentifier, &size, nil, 0)

  return String(cString: modelIdentifier)
}

extension Application {
  static var device: Device {
    let info = ProcessInfo.processInfo
    return Device(
      name: info.hostName,
      systemName: "macOS",
      systemVersion: info.operatingSystemVersionString,
      model: model(),
      id: .mac(copy_mac_address())
    )
  }
}
#endif
