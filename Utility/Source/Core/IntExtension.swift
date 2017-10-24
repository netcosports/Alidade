import Foundation

public extension Int {

  static func random(max: UInt32 = .max) -> Int { return Int(truncatingIfNeeded: arc4random_uniform(max)) }

  var isEven: Bool { return self % 2 == 0 }

  func cycleClamp(_ min: Int, _ max: Int) -> Int {
    if self >= min && self <= max { return self }
    let range = max - min
    let value = self % range
    if value < min { return value + range }
    if value > max { return value - range }
    return value
  }
}
