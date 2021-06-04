//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

public extension CGRect {

  init(size: CGSize) { self.init(origin: .zero, size: size) }

  var midpoint: CGPoint { return CGPoint(x: midX, y: midY) }

}
