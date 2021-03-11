//
//  Created by Dmitry Duleba on 10/24/17.
//

import CoreGraphics

public extension CGPoint {

  var normalized: CGPoint {
    let length = sqrt(x * x + y * y)
    guard length > 0.0 else { return CGPoint(x: 1.0, y: 0.0) }

    return CGPoint(x: x / length, y: y / length)
  }

  var clampNormal: CGPoint { return clamp(CGPoint.zero, CGPoint(x: 1.0, y: 1.0)) }

  //swiftlint:disable identifier_name
  func clamp(_ min: CGPoint, _ max: CGPoint) -> CGPoint {
    var p = self
    if p.x > max.x { p.x = max.x }
    if p.x < min.x { p.x = min.x }
    if p.y > max.y { p.y = max.y }
    if p.y < min.y { p.y = min.y }
    return p
  }
  //swiftlint:enable identifier_name
}
