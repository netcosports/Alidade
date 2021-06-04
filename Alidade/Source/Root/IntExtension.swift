//
//  Created by Dmitry Duleba on 10/24/17.
//

import CoreGraphics

public extension Int {

  var isOdd: Bool { return !isMultiple(of: 2) }

  var isEven: Bool { return isMultiple(of: 2) }

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

}

public extension SignedInteger {

  var abs: Self { return Swift.abs(self) }

}

public extension BinaryInteger {

  var int: Int { return Int(self) }

}

public extension BinaryInteger where Self: CVarArg {

  /** Formatted representation

   @code

   let someInt = 4, someIntFormat = "03"
   print("The integer number \(someInt) formatted with \"\(someIntFormat)\"
   looks like \(someInt.format(someIntFormat))")
   // The integer number 4 formatted with "03" looks like 004

   @endcode
   */
  func formatted(_ format: String) -> String {
    return String(format: "%\(format)d", self)
  }

}
