//
//  Created by Dmitry Duleba on 3/26/19.
//

import UIKit

private let _animator = FunctionalAnimation.Animator()

public extension UIView {

  var animator: FunctionalAnimation.Animator { return _animator }

}
