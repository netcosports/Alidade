import Foundation
import UIKit

public extension CGRect {

  init(size: CGSize) { self.init(origin: .zero, size: size) }

  var hashValue: Int { return origin.hashValue ^ size.hashValue }

  var midpoint: CGPoint { return CGPoint(x: midX, y: midY) }

}
