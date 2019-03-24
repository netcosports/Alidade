import UIKit

public extension CGAffineTransform {

  var translation: CGPoint {
    return CGPoint(x: tx, y: ty)
  }

  var rotation: CGFloat {
    return atan2(b, a)
  }

  var scale: CGPoint {
    return CGPoint(x: a, y: d)
  }

  static func += (left: inout CGAffineTransform, right: CGAffineTransform) {
    left = left.concatenating(right)
  }

}

public func + (left: CGAffineTransform, right: CGAffineTransform) -> CGAffineTransform {
  return left.concatenating(right)
}

public prefix func ! (transform: CGAffineTransform) -> CGAffineTransform {
  return transform.inverted()
}
