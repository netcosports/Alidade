import Foundation

public extension UIView {

  func scrollViewsInSubviews() -> [UIScrollView] {
    return subviews.flatMap {
      [($0 as? UIScrollView)].flatMap { $0 } + $0.scrollViewsInSubviews()
    }
  }
}
