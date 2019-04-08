//
//  Created by Dmitry Duleba on 10/24/17.
//

import struct CoreGraphics.CGPoint

public extension CGPoint {

  var normalized: CGPoint {
    let length = self.length
    guard length > 0.0 else { return CGPoint(x: 1.0, y: 0.0) }

    return CGPoint(x: x / length, y: y / length)
  }

  var clampNormal: CGPoint { return clamp(CGPoint.zero, CGPoint(x: 1.0, y: 1.0)) }

}
