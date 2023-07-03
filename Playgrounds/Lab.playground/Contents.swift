protocol Unit: Identifiable {
  associatedtype Value: FixedWidthInteger

  var id: String { get }
  var value: Value { get }
}

struct Register<T: FixedWidthInteger>: Unit {
  let id: String
  var value: T
}

let rAC = Register(id: "AC", value: UInt8(0))
let rPC = Register(id: "PC", value: UInt8(0))

let rAddr = Register(id: "MemAddr", value: UInt8(0))
let rData = Register(id: "MemData", value: Int8(0))

func print<T: Unit>(_ unit: T) { print("\(unit.id): \(unit.value)") }

print(rAC)
print(rPC)

typealias Group<T: Unit> = Array<T>

let unsigned = [rAC, rPC, rAddr]
let signed = [rData]

func print<T>(_ group: Group<T>) {
  for register in group {
    print(register)
  }
}

print("Unsigned:")
print(unsigned)

print("\nSigned:")
print(signed)
