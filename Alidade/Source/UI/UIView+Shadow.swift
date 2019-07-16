//
//  Created by Dmitry Duleba on 4/8/19.
//

import UIKit

public extension UIView {

  struct Shadow {
    public var color: UIColor?
    public var blur: CGFloat
    public var opacity: CGFloat
    public var offset: CGPoint
    public var path: CGPath?

    public static func sketch(color: UIColor? = nil,
                              alpha: CGFloat = 0.5,
                              bounds: CGRect,
                              x: CGFloat = 0, y: CGFloat = 0,
                              blur: CGFloat = 4.0,
                              spread: CGFloat = 0) -> Shadow {
      var path: CGPath?
      if spread == 0 {
        path = nil
      } else {
        let rect = bounds.insetBy(dx: -spread, dy: spread)
        path = UIBezierPath(rect: rect).cgPath
      }
      return Shadow(color: color, blur: blur * 0.5, opacity: alpha, offset: CGPoint(x: x, y: y), path: path)
    }

    public init(color: UIColor? = nil, blur: CGFloat = 10.0, opacity: CGFloat = 1.0,
                offset: CGPoint = .zero, path: CGPath? = nil) {
      self.color = color
      self.blur = blur
      self.opacity = opacity
      self.offset = offset
      self.path = path
    }

  }

  var shadow: Shadow {
    get {
      return Shadow(color: layer.shadowColor.map { UIColor(cgColor: $0) },
                    blur: layer.shadowRadius,
                    opacity: layer.shadowOpacity.cg,
                    offset: CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height),
                    path: layer.shadowPath)
    }
    set {
      layer.shadowColor = newValue.color?.cgColor
      layer.shadowRadius = newValue.blur
      layer.shadowPath = newValue.path
      layer.shadowOpacity = Float(newValue.opacity)
      layer.shadowOffset = CGSize(width: newValue.offset.x, height: newValue.offset.y)
    }
  }

}
