import Foundation
import UIKit

public extension CGFloat {

  /** Formatted representation
   
   @code
   
   let someFloat = 3.14159265359, someFloatFormat = ".3"
   println("The floating point number \(someFloat) formatted with \"\(someFloatFormat)\"
   looks like \(someFloat.format(someFloatFormat))")
   // The floating point number 3.14159265359 formatted with ".3" looks like 3.142
   
   @endcode
   */
  func formatted(_ format: String) -> String {
    return String(format: "%\(format)f", self)
  }
}

public extension Double {

  /** Formatted representation
   
   @code
   
   let someDouble = 3.14159265359, someDoubleFormat = ".3"
   println("The floating point number \(someDouble) formatted with \"\(someDoubleFormat)\"
   looks like \(someDouble(someDoubleFormat))")
   // The floating point number 3.14159265359 formatted with ".3" looks like 3.142
   
   @endcode
   */
  func formatted(_ format: String) -> String {
    return String(format: "%\(format)f", self)
  }
}
