import UIKit

public extension CGPoint {

  var normalized: CGPoint {
    let length = self.length
    guard length > 0.0 else { return CGPoint(x: 1.0, y: 0.0) }

    return CGPoint(x: x / length, y: y / length)
  }

  var rounded: CGPoint { return CGPoint(x: x.rounded(), y: y.rounded()) }

  var length: CGFloat { return sqrt(x * x + y * y) }

  var sizeValue: CGSize { return CGSize(width: x, height: y) }

  var clampNormal: CGPoint { return clamp(CGPoint.zero, CGPoint(x: 1.0, y: 1.0)) }

  func clamp(_ min: CGPoint, _ max: CGPoint) -> CGPoint {
    var p = self
    if p.x > max.x { p.x = max.x }
    if p.x < min.x { p.x = min.x }
    if p.y > max.y { p.y = max.y }
    if p.y < min.y { p.y = min.y }
    return p
  }

  var hashValue: Int {
    return x.hashValue ^ y.hashValue
  }
}
