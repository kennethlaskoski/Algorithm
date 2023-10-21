protocol Digit: Hashable {
  var symbol: Character { get }
  var number: Int { get }

  static var zero: Self { get }
  static var unit: Self { get }
}

enum BinaryDigit: Int {
  case zero
  case unit
}

extension BinaryDigit: Digit {
  var number: Int { rawValue }
  var symbol: Character {
    switch (self) {
    case .zero:
      return "0"
    case .unit:
      return "1"
    }
  }
}

protocol Numeral: CustomStringConvertible {
  associatedtype Element: Digit

  typealias Base = Set<Element>
  static var base: Base { get }
  static var radix: Int { get }

  associatedtype Notation: Sequence<Element>
  var notation: Notation { get }

  var number: Int { get }
}

extension Numeral {
  static var radix: Int { base.count }

  var number: Int {
    var result = 0
    var positional = 1
    for digit in notation {
      result += digit.number * positional
      positional *= Self.radix
    }
    return result
  }
}

struct BinaryNumeral: Numeral {
  static let base: Set<BinaryDigit> = [.zero, .unit]

  let notation: [BinaryDigit]
  var description: String { String(notation.reversed().map { $0.symbol }) }
}

let five = BinaryNumeral(notation: [.unit, .zero, .unit])
print(five)
print(five.number)

//protocol Unit: Identifiable {
//  associatedtype Value: FixedWidthInteger
//
//  var id: String { get }
//  var value: Value { get }
//}
//
//struct Register<T: FixedWidthInteger>: Unit {
//  let id: String
//  var value: T
//}
//
//let rAC = Register(id: "AC", value: UInt8(0))
//let rPC = Register(id: "PC", value: UInt8(0))
//
//let rAddr = Register(id: "MemAddr", value: UInt8(0))
//let rData = Register(id: "MemData", value: Int8(0))
//
//func print<T: Unit>(_ unit: T) { print("\(unit.id): \(unit.value)") }
//
//print(rAC)
//print(rPC)
//
//typealias Group<T: Unit> = Array<T>
//
//let unsigned = [rAC, rPC, rAddr]
//let signed = [rData]
//
//func print<T>(_ group: Group<T>) {
//  for register in group {
//    print(register)
//  }
//}
//
//print("Unsigned:")
//print(unsigned)
//
//print("\nSigned:")
//print(signed)
