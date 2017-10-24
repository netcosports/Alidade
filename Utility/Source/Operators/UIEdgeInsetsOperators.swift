import UIKit

prefix func - (insets: UIEdgeInsets) -> UIEdgeInsets {
  return insets * CGFloat(-1.0)
}

public func + (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
  return UIEdgeInsets(top: left.top + right.top, left: left.left + right.left,
                      bottom: left.bottom + right.bottom, right: left.right + right.right)
}

public func - (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
  return left + (-right)
}

func * (left: UIEdgeInsets, right: CGFloat) -> UIEdgeInsets {
  return UIEdgeInsets(top: left.top * right, left: left.left * right,
                      bottom: left.bottom * right, right: left.right * right)
}

public func / (left: UIEdgeInsets, right: CGFloat) -> UIEdgeInsets {
  return left * (1.0 / right)
}
