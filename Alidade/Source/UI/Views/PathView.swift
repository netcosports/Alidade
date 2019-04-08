//
//  Created by Dmitry Duleba on 10/24/17.
//

import UIKit

public class PathView: UIView {

  open var path: CGPath? { didSet { (layer as? CAShapeLayer)?.path = path } }
  open var color: UIColor? { didSet { (layer as? CAShapeLayer)?.fillColor = color?.cgColor } }

  override open class var layerClass: AnyClass {
    return CAShapeLayer.self
  }
}
