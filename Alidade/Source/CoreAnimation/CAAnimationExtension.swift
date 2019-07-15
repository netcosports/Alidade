//
//  Created by Dmitry Duleba on 4/8/19.
//

import UIKit

public typealias CAAnimationCallback = (CAAnimation, Bool) -> Void

private class CallbackAnimationDelegate: NSObject, CAAnimationDelegate {

  public var didStart: CAAnimationCallback?
  public var didStop: CAAnimationCallback?

  public func animationDidStart(_ anim: CAAnimation) {
    if let didStart = didStart {
      didStart(anim, true)
    }
  }

  public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if let didStop = didStop {
      didStop(anim, flag)
    }
  }
}

public extension CAAnimation {

  var didStart: CAAnimationCallback? {
    get { return (delegate as? CallbackAnimationDelegate)?.didStart }
    set {
      if delegate == nil {
        delegate = CallbackAnimationDelegate()
        (delegate as? CallbackAnimationDelegate)?.didStart = newValue
        return
      }
      if let delegate = delegate as? CallbackAnimationDelegate {
        delegate.didStart = newValue
        self.delegate = delegate
      }
    }
  }

  var didStop: CAAnimationCallback? {
    get { return (delegate as? CallbackAnimationDelegate)?.didStop }
    set {
      if delegate == nil {
        delegate = CallbackAnimationDelegate()
        (delegate as? CallbackAnimationDelegate)?.didStop = newValue
        return
      }
      if let delegate = delegate as? CallbackAnimationDelegate {
        delegate.didStop = newValue
        self.delegate = delegate
      }
    }
  }

}
