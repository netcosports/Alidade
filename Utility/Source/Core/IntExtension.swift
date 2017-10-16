//
//  Int+Custom.swift
//  Liverpool_FC
//
//  Created by Dmitry Duleba on 4/1/16.
//  Copyright © 2016 NETCOSPORTS. All rights reserved.
//

import Foundation

public extension Int {

  static func random(max: UInt32 = .max) -> Int {
    return Int(truncatingIfNeeded: arc4random_uniform(max))
  }
}

public extension Int {

  var isEven: Bool { return self % 2 == 0 }

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

  func clamp(_ min: Int, _ max: Int) -> Int {
    guard self > min else { return min }
    guard self < max else { return max }

    return self
  }

  func cycleClamp(_ min: Int, _ max: Int) -> Int {
    if self >= min && self <= max { return self }
    let range = max - min
    let value = self % range
    if value < min { return value + range }
    if value > max { return value - range }
    return value
  }
}
