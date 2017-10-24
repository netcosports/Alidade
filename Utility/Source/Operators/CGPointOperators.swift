import UIKit

extension CGPoint {

  func invert() -> CGPoint {
    return self * -1.0
  }

  func multiply(_ multiplier: CGFloat) -> CGPoint {
    return CGPoint(x: x * multiplier, y: y * multiplier)
  }

  public func isFuzzyEqual(to point: CGPoint, epsilon: CGFloat = .epsilon) -> Bool {
    return point.x.isFuzzyEqual(to: x, epsilon: epsilon)
      && point.y.isFuzzyEqual(to: y, epsilon: epsilon)
  }
}

public func << (left: CGPoint, right: CGAffineTransform) -> CGPoint {
  return left.applying(right)
}

public prefix func - (point: CGPoint) -> CGPoint {
  return point.invert()
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
  return left.multiply(right)
}

public func * (left: CGFloat, right: CGPoint) -> CGPoint {
  return right.multiply(left)
}

public func * (left: CGPoint, right: Double) -> CGPoint {
  return left.multiply(CGFloat(right))
}

public func * (left: Double, right: CGPoint) -> CGPoint {
  return right.multiply(CGFloat(left))
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
  return left * (1.0 / right)
}

// MARK: - Vectors

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
