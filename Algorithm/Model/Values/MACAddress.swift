//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

typealias mac_address_t = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

struct MACAddress: Sendable {
  private(set) var macAddress: mac_address_t = (0, 0, 0, 0, 0, 0)
}

extension MACAddress {
  static var null: MACAddress = MACAddress()
}

extension MACAddress {
  init(bytes: Data) {
    precondition(bytes.count == 6)
    withUnsafeMutableBytes(of: &macAddress) {
      $0.copyBytes(from: bytes)
    }
  }

  var bytes: Data {
    withUnsafeBytes(of: macAddress) {
      Data($0)
    }
  }
}

extension MACAddress: Codable {
  init(from decoder: Decoder) throws {
    try self.init(bytes: Data(from: decoder))
  }

  func encode(to encoder: Encoder) throws {
    try bytes.encode(to: encoder)
  }
}

extension MACAddress {
  var macAddressString: String {
    withUnsafeBytes(of: macAddress) {
      $0.map { String(format: "%02X", $0) }.joined(separator: ":")
    }
  }
}

//extension MACAddress: CustomStringConvertible {
//  var description: String { macAddressString }
//}

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

func copy_mac_address() -> MACAddress {
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

extension Application {
  static var device: Device { .mac(copy_mac_address()) }
}
#endif
