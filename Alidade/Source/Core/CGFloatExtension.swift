import UIKit
import Foundation

public extension CGFloat {

  static let epsilon: CGFloat = CGFloat(ulpOfOne)

  static var random: CGFloat { return CGFloat.random(in: 0...1) }

  static var pixel: CGFloat { return 1.0 / UIScreen.main.scale }

  var sign: CGFloat { return self < 0.0 ? -1.0 : 1.0 }

  var normalized: CGFloat { return clamp(0.0, 1.0) }

  func cycleClamp(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
    if self >= min && self <= max { return self }
    let range = max - min
    let value = truncatingRemainder(dividingBy: range)
    if value < min { return value + range }
    if value > max { return value - range }
    return value
  }

  func isFuzzyEqual(to value: CGFloat, epsilon: CGFloat = CGFloat(ulpOfOne)) -> Bool {
    return abs(self - value) <= epsilon
  }

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
