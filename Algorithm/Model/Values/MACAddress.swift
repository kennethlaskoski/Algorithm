//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

typealias mac_address_t = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

struct MACAddress: Sendable {
  private(set) var macAddress: mac_address_t = (0, 0, 0, 0, 0, 0)
}

extension MACAddress {
  static let null: MACAddress = MACAddress()
  var isNull: Bool { self == .null }
}

extension MACAddress: Equatable {
  static func == (lhs: MACAddress, rhs: MACAddress) -> Bool {
    lhs.macAddress == rhs.macAddress
  }
}

extension MACAddress: Comparable {
  static func < (lhs: MACAddress, rhs: MACAddress) -> Bool {
    lhs.macAddress < rhs.macAddress
  }
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

extension MACAddress: CustomStringConvertible {
  var description: String {
    withUnsafeBytes(of: macAddress) {
      $0.map { String(format: "%02X", $0) }.joined(separator: ":")
    }
  }
}
