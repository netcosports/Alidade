import UIKit

public extension CGPoint {

  public var normalized: CGPoint {
    let length = self.length
    guard length > 0.0 else { return CGPoint(x: 1.0, y: 0.0) }

    return CGPoint(x: x / length, y: y / length)
  }

  public var rounded: CGPoint { return CGPoint(x: x.rounded(), y: y.rounded()) }

  public var ceiled: CGPoint { return CGPoint(x: ceil(x), y: ceil(y)) }

  public var floored: CGPoint { return CGPoint(x: floor(x), y: floor(y)) }

  public var length: CGFloat { return sqrt(x * x + y * y) }

  public var sizeValue: CGSize { return CGSize(width: x, height: y) }

  public var clampNormal: CGPoint { return clamp(CGPoint.zero, CGPoint(x: 1.0, y: 1.0)) }

  public func clamp(_ min: CGPoint, _ max: CGPoint) -> CGPoint {
    var p = self
    if p.x > max.x { p.x = max.x }
    if p.x < min.x { p.x = min.x }
    if p.y > max.y { p.y = max.y }
    if p.y < min.y { p.y = min.y }
    return p
  }
  
  public func isFuzzyEqual(to point: CGPoint, epsilon: CGFloat = .epsilon) -> Bool {
    return point.x.isFuzzyEqual(to: x, epsilon: epsilon)
      && point.y.isFuzzyEqual(to: y, epsilon: epsilon)
  }

  public var hashValue: Int {
    return x.hashValue ^ y.hashValue
  }
}
