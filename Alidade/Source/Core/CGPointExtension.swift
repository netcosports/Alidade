//
//  Created by Dmitry Duleba on 10/24/17.
//

import struct CoreGraphics.CGPoint

public extension CGPoint {

  var normalized: CGPoint {
    let length = sqrt(x * x + y * y)
    guard length > 0.0 else { return CGPoint(x: 1.0, y: 0.0) }

    return CGPoint(x: x / length, y: y / length)
  }

  var clampNormal: CGPoint { return clamp(CGPoint.zero, CGPoint(x: 1.0, y: 1.0)) }

  func clamp(_ min: CGPoint, _ max: CGPoint) -> CGPoint {
    let realMin = Swift.min(min, max)
    let realMax = Swift.max(min, max)
    return Swift.min(Swift.max(self, realMin), realMax)
  }
}

extension CGPoint: Comparable {

  public static func < (lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x < rhs.x && lhs.y < rhs.y
  }
}
