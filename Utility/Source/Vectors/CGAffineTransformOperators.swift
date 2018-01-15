import UIKit

public extension CGAffineTransform {

  var translation: CGPoint {
    return CGPoint(x: tx, y: ty)
  }
}

public func + (left: CGAffineTransform, right: CGAffineTransform) -> CGAffineTransform {
  return left.concatenating(right)
}

public prefix func ! (transform: CGAffineTransform) -> CGAffineTransform {
  return transform.inverted()
}

public func << (left: CGPoint, right: CGAffineTransform) -> CGPoint {
  return left.applying(right)
}

public func << (left: CGRect, right: CGAffineTransform) -> CGRect {
  return left.applying(right)
}
