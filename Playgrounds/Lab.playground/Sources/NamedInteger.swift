//import Foundation
//
//struct NamedInteger<FWI: FixedWidthInteger> {
//  let name: String
//  let value: FWI
//
//  init(name: String, value: FWI) {
//    self.name = name
//    self.value = value
//  }
//
//  init(_ source: FWI) {
//    self.init(name: String(source), value: source)
//  }
//}
//
//extension NamedInteger: FixedWidthInteger {
//  init(_truncatingBits bits: UInt) {
//    self = 0
//  }
//
//  func addingReportingOverflow(_ rhs: NamedInteger<FWI>) -> (partialValue: NamedInteger<FWI>, overflow: Bool) {
//    (0, false)
//  }
//
//  func subtractingReportingOverflow(_ rhs: NamedInteger<FWI>) -> (partialValue: NamedInteger<FWI>, overflow: Bool) {
//    (0, false)
//  }
//
//  func multipliedReportingOverflow(by rhs: NamedInteger<FWI>) -> (partialValue: NamedInteger<FWI>, overflow: Bool) {
//    (0, false)
//  }
//
//  func dividedReportingOverflow(by rhs: NamedInteger<FWI>) -> (partialValue: NamedInteger<FWI>, overflow: Bool) {
//    (0, false)
//  }
//
//  func remainderReportingOverflow(dividingBy rhs: NamedInteger<FWI>) -> (partialValue: NamedInteger<FWI>, overflow: Bool) {
//    (0, false)
//  }
//
//  func dividingFullWidth(_ dividend: (high: NamedInteger<FWI>, low: FWI.Magnitude)) -> (quotient: NamedInteger<FWI>, remainder: NamedInteger<FWI>) {
//    (0, 0)
//  }
//
//
//
//  static func *= (lhs: inout NamedInteger<FWI>, rhs: NamedInteger<FWI>) {
//    lhs = NamedInteger(name: lhs.name, value: lhs.value * rhs.value)
//  }
//
//  static func /= (lhs: inout NamedInteger<FWI>, rhs: NamedInteger<FWI>) {
//    lhs = NamedInteger(name: lhs.name, value: lhs.value / rhs.value)
//  }
//
//  static func %= (lhs: inout NamedInteger<FWI>, rhs: NamedInteger<FWI>) {
//    lhs = NamedInteger(name: lhs.name, value: lhs.value % rhs.value)
//  }
//
//  static func &= (lhs: inout NamedInteger<FWI>, rhs: NamedInteger<FWI>) {
//    lhs = NamedInteger(name: lhs.name, value: lhs.value & rhs.value)
//  }
//
//  static func |= (lhs: inout NamedInteger<FWI>, rhs: NamedInteger<FWI>) {
//    lhs = NamedInteger(name: lhs.name, value: lhs.value | rhs.value)
//  }
//
//  static func ^= (lhs: inout NamedInteger<FWI>, rhs: NamedInteger<FWI>) {
//    lhs = NamedInteger(name: lhs.name, value: lhs.value ^ rhs.value)
//  }
//
//
//
//  static func + (lhs: NamedInteger<FWI>, rhs: NamedInteger<FWI>) -> NamedInteger<FWI> {
//    NamedInteger(name: lhs.name + "+" + rhs.name, value: lhs.value + rhs.value)
//  }
//
//  static func - (lhs: NamedInteger<FWI>, rhs: NamedInteger<FWI>) -> NamedInteger<FWI> {
//    NamedInteger(name: lhs.name + "-" + rhs.name, value: lhs.value - rhs.value)
//  }
//
//  static func * (lhs: NamedInteger<FWI>, rhs: NamedInteger<FWI>) -> NamedInteger<FWI> {
//    NamedInteger(name: lhs.name + "*" + rhs.name, value: lhs.value * rhs.value)
//  }
//
//  static func / (lhs: NamedInteger<FWI>, rhs: NamedInteger<FWI>) -> NamedInteger<FWI> {
//    NamedInteger(name: lhs.name + "/" + rhs.name, value: lhs.value / rhs.value)
//  }
//
//  static func % (lhs: NamedInteger<FWI>, rhs: NamedInteger<FWI>) -> NamedInteger<FWI> {
//    NamedInteger(name: lhs.name + "%" + rhs.name, value: lhs.value % rhs.value)
//  }
//
//  static var bitWidth: Int { FWI.bitWidth }
//  static var isSigned: Bool { FWI.isSigned }
//  static var max: NamedInteger<FWI> { NamedInteger(name: "max", value: FWI.max) }
//  static var min: NamedInteger<FWI> { NamedInteger(name: "min", value: FWI.min) }
//
//  var words: FWI.Words { value.words }
//  var magnitude: FWI.Magnitude { value.magnitude }
//  var nonzeroBitCount: Int { value.nonzeroBitCount }
//  var leadingZeroBitCount: Int { value.leadingZeroBitCount }
//  var trailingZeroBitCount: Int { value.trailingZeroBitCount }
//  var byteSwapped: NamedInteger<FWI> { NamedInteger(name: name + ".byteSwapped", value: value.byteSwapped) }
//
//  init<T>(_ source: T) where T : BinaryInteger {
//    self.init(FWI(source))
//  }
//
//  init<T>(truncatingIfNeeded source: T) where T : BinaryInteger {
//    self.init(FWI(truncatingIfNeeded: source))
//  }
//
//  init?<T>(exactly source: T) where T : BinaryInteger {
//    guard let source = FWI(exactly: source) else {
//      return nil
//    }
//    self.init(source)
//  }
//
//  init(integerLiteral value: FWI.IntegerLiteralType) {
//    self.init(FWI(integerLiteral: value))
//  }
//}
//
//
