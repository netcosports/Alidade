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
