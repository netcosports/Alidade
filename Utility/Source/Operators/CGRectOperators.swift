import Foundation

public func << (left: CGRect, right: CGAffineTransform) -> CGRect {
  return left.applying(right)
}
