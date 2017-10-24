import Foundation

public extension Int {

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
