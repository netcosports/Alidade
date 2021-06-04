//
//  Created by Dmitry Duleba on 10/24/17.
//

import UIKit

// MARK: - Show/Hide

private struct AssociatedKeys {

  static var HidingKey = "hiding"
  static var ShowingKey = "showing"
}

public extension UIView {

  // MARK: - Properties

  private var showing: Bool {
    get { return objc_getAssociatedObject(self, &AssociatedKeys.ShowingKey) as? Bool ?? false }
    set { objc_setAssociatedObject(self, &AssociatedKeys.ShowingKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
  }

  private var hiding: Bool {
    get { return objc_getAssociatedObject(self, &AssociatedKeys.HidingKey) as? Bool ?? false }
    set { objc_setAssociatedObject(self, &AssociatedKeys.HidingKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
  }

  // MARK: - Functions

  func setHidden(_ hidden: Bool, animated: Bool = false, force: Bool = false,
                 completion: (() -> Void)? = nil) {
    let duration = animated ? 0.3 : 0.0
    setHidden(hidden, duration: duration, force: force, completion: completion)
  }

  func setHidden(_ hidden: Bool, duration: TimeInterval, force: Bool = false,
                 completion: (() -> Void)? = nil) {
    if hidden {
      hide(animationDuration: duration, force: force, completion: completion)
    } else {
      show(animationDuration: duration, force: force, completion: completion)
    }
  }

  private func hide(animationDuration: TimeInterval = 0.0, force: Bool = false,
                    completion: (() -> Void)? = nil) {
    guard (!isHidden && !hiding) || showing || force else {
      completion?()
      return
    }

    guard animationDuration > 0.0 else {
      isHidden = true
      completion?()
      return
    }

    hiding = true
    UIView.animate(withDuration: animationDuration, animations: { [weak self] in
      self?.alpha = 0.0
      }, completion: { [weak self] _ in
        guard let selfStrong = self else { return }

        selfStrong.isHidden = !selfStrong.showing
        selfStrong.hiding = false
        completion?()
      }
    )
  }

  private func show(animationDuration: TimeInterval = 0.0, force: Bool = false, completion: (() -> Void)? = nil) {
    guard (isHidden && !showing) || hiding || force else {
      completion?()
      return
    }

    isHidden = false
    guard animationDuration > 0 else {
      completion?()
      return
    }

    showing = true
    alpha = 0.0
    UIView.animate(withDuration: animationDuration, animations: { [weak self] in
      self?.alpha = 1.0
      }, completion: { [weak self] _ in
        guard let selfStrong = self else { return }

        selfStrong.isHidden = selfStrong.hiding
        selfStrong.showing = false
        completion?()
      }
    )
  }
}
