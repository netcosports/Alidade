import UIKit

extension CGPoint {

  public func isFuzzyEqual(to point: CGPoint, epsilon: CGFloat = .epsilon) -> Bool {
    return point.x.isFuzzyEqual(to: x, epsilon: epsilon)
      && point.y.isFuzzyEqual(to: y, epsilon: epsilon)
  }
}
