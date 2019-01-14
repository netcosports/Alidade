import Foundation

public extension Int {

  @available(iOS, deprecated, message: "Deprecated in swift 4.2")
  static func random(max: Int = .max) -> Int { return Int.random(in: 0..<max) }

  var isEven: Bool { return self % 2 == 0 }

  //swiftlint:disable:next identifier_name
  var cg: CGFloat { return CGFloat(self) }

  func cycleClamp(_ min: Int, _ max: Int) -> Int {
    guard max > min else { return cycleClamp(max, min) }
    if self >= min && self <= max { return self }

    let range = max - min + 1
    let mod = self % range
    if mod < 0 { return mod + range }
    return mod
  }

  /** Formatted representation

   @code

   let someInt = 4, someIntFormat = "03"
   println("The integer number \(someInt) formatted with \"\(someIntFormat)\"
   looks like \(someInt.format(someIntFormat))")
   // The integer number 4 formatted with "03" looks like 004

   @endcode
   */
  func formatted(_ format: String) -> String {
    return String(format: "%\(format)d", self)
  }
}
