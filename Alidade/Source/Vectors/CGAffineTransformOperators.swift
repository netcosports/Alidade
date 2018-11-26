import UIKit

public extension CGAffineTransform {

  public var translation: CGPoint {
    return CGPoint(x: tx, y: ty)
  }

  public static func +=(left: inout CGAffineTransform, right: CGAffineTransform) {
    left = left.concatenating(right)
  }

}

public func + (left: CGAffineTransform, right: CGAffineTransform) -> CGAffineTransform {
  return left.concatenating(right)
}

public prefix func ! (transform: CGAffineTransform) -> CGAffineTransform {
  return transform.inverted()
}
