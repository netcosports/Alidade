import Foundation
import UIKit

public extension CGSize {

  init(side: Int) { self.init(width: side, height: side) }

  init(side: CGFloat) { self.init(width: side, height: side) }

  init(side: Double) { self.init(width: side, height: side) }

  var pointValue: CGPoint { return CGPoint(x: width, y: height) }

  var rectValue: CGRect { return CGRect(origin: .zero, size: self) }

  var hashValue: Int { return width.hashValue ^ height.hashValue }

  var rounded: CGSize { return CGSize(width: width.rounded(), height: height.rounded()) }

  var ceiled: CGSize { return CGSize(width: ceil(width), height: ceil(height)) }

  var floored: CGSize { return CGSize(width: floor(width), height: floor(height)) }

  var integral: CGSize { return CGRect(size: self).integral.size }

  var standartized: CGSize { return CGRect(size: self).standardized.size }

  var isEmpty: Bool { return CGRect(size: self).isEmpty }

  var isNull: Bool { return CGRect(size: self).isNull }

  var isInfinite: Bool { return CGRect(size: self).isInfinite }

}
