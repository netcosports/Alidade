//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

public extension CGSize {

  init(side: Int) { self.init(width: side, height: side) }

  init(side: CGFloat) { self.init(width: side, height: side) }

  init(side: Double) { self.init(width: side, height: side) }

  var rectValue: CGRect { return CGRect(origin: .zero, size: self) }

  var integral: CGSize { return CGRect(size: self).integral.size }

  var standartized: CGSize { return CGRect(size: self).standardized.size }

  var isEmpty: Bool { return CGRect(size: self).isEmpty }

  var isNull: Bool { return CGRect(size: self).isNull }

  var isInfinite: Bool { return CGRect(size: self).isInfinite }

  var minSide: CGFloat { return min(width, height) }

  var maxSide: CGFloat { return max(width, height) }

  var aspectRatio: CGFloat { return height != 0 ? width / height : 0.0 }

}
