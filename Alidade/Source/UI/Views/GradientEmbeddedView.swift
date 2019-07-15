//
//  Created by Dmitry Duleba on 12/17/18.
//

import UIKit

open class GradientEmbeddedView<E: UIView>: GradientView {

  let embedded = E.init()

  // MARK: - Init

  required public init(with constructor: (E) -> Void) {
    super.init(frame: .zero)
    constructor(embedded)
    setup()
  }

  required public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: - Lifecycle

  override open var intrinsicContentSize: CGSize {
    return embedded.intrinsicContentSize
  }

  override open func sizeThatFits(_ size: CGSize) -> CGSize {
    return embedded.sizeThatFits(size)
  }

  open func setup() {
    layer.mask = embedded.layer
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    embedded.frame = bounds
  }

}
