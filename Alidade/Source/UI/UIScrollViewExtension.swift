import UIKit

public extension UIScrollView {

  enum Position {
    case top
    case left
    case right
    case bottom
  }

  func isCurrently(at position: Position) -> Bool {
    let offset = contentOffset(for: position)
    return offset == self.contentOffset
  }

  func scroll(to position: Position, animated: Bool) {
    let offset = contentOffset(for: position)
    setContentOffset(offset, animated: animated)
  }

  private func contentOffset(for position: Position) -> CGPoint {
    let offset: CGPoint
    switch position {
    case .top:    offset = CGPoint(x: contentOffset.x, y: -contentInset.top)
    case .left:   offset = CGPoint(x: -contentInset.left, y: contentOffset.y)
    case .right:  offset = CGPoint(x: contentSize.width - bounds.size.width, y: contentOffset.y)
    case .bottom: offset = CGPoint(x: contentOffset.x, y: contentSize.height - bounds.size.height)
    }
    return offset
  }
}
