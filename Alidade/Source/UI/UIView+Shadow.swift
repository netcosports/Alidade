//
//  Created by Dmitry Duleba on 4/8/19.
//

import UIKit

public extension UIView {
  private enum Associated {
    static var boundsKVO = "bounds_kvo"
  }

  private var boundsKVO: NSKeyValueObservation? {
    set {
      objc_setAssociatedObject(self,
                               &Associated.boundsKVO,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    get {
      return objc_getAssociatedObject(self, &Associated.boundsKVO) as? NSKeyValueObservation
    }
  }

  struct Shadow {
    public var color: UIColor
    public var alpha: CGFloat
    public var x: CGFloat
    public var y: CGFloat
    public var blur: CGFloat
    public var spread: CGFloat

    func path(for bounds: CGRect) -> CGPath {
      let rect = bounds.insetBy(dx: -spread, dy: spread)
      return UIBezierPath(rect: rect).cgPath
    }

    var offset: CGPoint {
      return CGPoint(x: x, y: y)
    }

    public static func sketch(color: UIColor,
                              x: CGFloat = 0,
                              y: CGFloat = 0,
                              blur: CGFloat = 4.0,
                              spread: CGFloat = 0) -> Shadow {
      return Shadow(color: color.withAlphaComponent(1.0),
                    alpha: color.cgColor.alpha,
                    x: x, y: y,
                    blur: blur * 0.5,
                    spread: spread)
    }

    init(color: UIColor,
         alpha: CGFloat,
         x: CGFloat,
         y: CGFloat,
         blur: CGFloat,
         spread: CGFloat) {
      self.color = color
      self.alpha = alpha
      self.x = x
      self.y = y
      self.blur = blur
      self.spread = spread
    }

  }

  var shadow: Shadow {
    get {
      return Shadow(color: .black, alpha: 0.0, x: 0.0, y: 0.0, blur: 0.0, spread: 0.0)
    }
    set {
      if !frame.isEmpty { applyShadow(shadow: newValue) }
      if boundsKVO == nil {
        boundsKVO = observe(\.bounds) { [weak self] view, _ in
          if view.frame.isEmpty == false {
            self?.applyShadow(shadow: newValue)
          }
        }
      }
    }
  }

  private func applyShadow(shadow: Shadow) {
    layer.shadowColor = shadow.color.cgColor
    layer.shadowRadius = shadow.blur
    layer.shadowPath = shadow.path(for: bounds)
    layer.shadowOpacity = Float(shadow.alpha)
    layer.shadowOffset = CGSize(width: shadow.offset.x, height: shadow.offset.y)
  }
}

