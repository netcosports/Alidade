//
//  Created by Dmitry Duleba on 3/22/19.
//

import struct UIKit.CGVector
import struct UIKit.CGPoint
import struct UIKit.CGSize
import struct UIKit.UIOffset
import struct UIKit.CGFloat

public extension SIMD where Scalar == CGFloat, MaskStorage == SIMD2<Scalar.SIMDMaskScalar> {

  var vectorValue: CGVector { return CGVector(dx: self[0], dy: self[1]) }

  var pointValue: CGPoint { return CGPoint(x: self[0], y: self[1]) }

  var sizeValue: CGSize { return CGSize(width: self[0], height: self[1]) }

  var offsetValue: UIOffset { return UIOffset(horizontal: self[0], vertical: self[1]) }

}
