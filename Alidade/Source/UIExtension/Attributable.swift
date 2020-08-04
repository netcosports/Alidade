//
//  Created by Sergey Krumin on 1/31/20.
//

import Foundation
import UIKit

public extension NSAttributedString.Key {
  static let uppercased = NSAttributedString.Key("uppercased")
}

public protocol Attributable {
  var attributes: [NSAttributedString.Key: Any] { get }
}

public extension String {
  func styled(as style: Attributable) -> NSAttributedString {
    let attributes = style.attributes
    let uppercased = attributes[.uppercased] != nil
    return NSAttributedString(string: uppercased ? self.uppercased() : self, attributes: attributes)
  }

  func styled(phone: Attributable,
              pad: Attributable) -> NSAttributedString {
    let style = UIDevice.current.userInterfaceIdiom == .pad ? pad : phone
    let attributes = style.attributes
    let uppercased = attributes[.uppercased] != nil
    return NSAttributedString(string: uppercased ? self.uppercased() : self, attributes: attributes)
  }
}

