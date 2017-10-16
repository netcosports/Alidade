import Foundation

public extension UIGestureRecognizer {

  public func removeFromView() {
    view?.removeGestureRecognizer(self)
  }

  public func cancel() {
    guard isEnabled else { return }

    isEnabled = false
    isEnabled = true
  }
}
