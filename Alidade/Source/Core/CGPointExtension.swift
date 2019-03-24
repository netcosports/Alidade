import UIKit

public extension CGPoint {

  var normalized: CGPoint {
    let length = self.length
    guard length > 0.0 else { return CGPoint(x: 1.0, y: 0.0) }

    return CGPoint(x: x / length, y: y / length)
  }

  var rounded: CGPoint { return CGPoint(x: x.rounded(), y: y.rounded()) }

  var ceiled: CGPoint { return CGPoint(x: ceil(x), y: ceil(y)) }

  var floored: CGPoint { return CGPoint(x: floor(x), y: floor(y)) }

  var length: CGFloat { return sqrt(x * x + y * y) }

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

  func distanceSquared(to point: CGPoint) -> CGFloat {
    return (point.x - x) * (point.x - x) + (point.y - y) * (point.y - y)
  }

  func distance(to point: CGPoint) -> CGFloat {
    return distanceSquared(to: point).squareRoot()
  }

  func isFuzzyEqual(to point: CGPoint, epsilon: CGFloat = .epsilon) -> Bool {
    return point.x.isFuzzyEqual(to: x, epsilon: epsilon)
      && point.y.isFuzzyEqual(to: y, epsilon: epsilon)
  }

}
