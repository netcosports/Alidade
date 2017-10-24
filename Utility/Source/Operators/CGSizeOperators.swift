import UIKit

public func * (left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width * right, height: left.height * right)
}

public func * (left: CGFloat, right: CGSize) -> CGSize {
  return right * left
}

public func * (left: CGSize, right: Double) -> CGSize {
  return CGSize(width: left.width * CGFloat(right), height: left.height * CGFloat(right))
}

public func * (left: Double, right: CGSize) -> CGSize {
  return right * left
}

public func / (left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width / right, height: left.height / right)
}

public func / (left: CGSize, right: Double) -> CGSize {
  return CGSize(width: left.width / CGFloat(right), height: left.height / CGFloat(right))
}
