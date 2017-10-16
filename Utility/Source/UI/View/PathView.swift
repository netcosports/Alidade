import UIKit

public class PathView: UIView {

  public var path: CGPath? { didSet { (layer as? CAShapeLayer)?.path = path } }
  public var color: UIColor? { didSet { (layer as? CAShapeLayer)?.fillColor = color?.cgColor } }

  override public class var layerClass: AnyClass {
    return CAShapeLayer.self
  }
}
