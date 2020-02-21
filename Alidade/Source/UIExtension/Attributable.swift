//
//  Created by Sergey Krumin on 1/31/20.
//

import Foundation
import UIKit

public protocol Attributable {
    var attributes: [NSAttributedString.Key: Any] { get }
}

public extension String {
  func styled(as style: Attributable) -> NSAttributedString {
    return NSAttributedString(string: self, attributes: style.attributes)
  }

  func styled(phone: Attributable,
              pad: Attributable) -> NSAttributedString {
    let style = UIDevice.current.userInterfaceIdiom == .pad ? pad : phone
    return NSAttributedString(string: self, attributes: style.attributes)
  }
}
