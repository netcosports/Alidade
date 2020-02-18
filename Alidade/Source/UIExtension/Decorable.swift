//
//  Created by Sergey Krumin on 2/18/20.
//

import UIKit

public typealias Decoration = (UIView) -> Void

public protocol Decorable {
  var decoration: Decoration { get }
}

extension Decorable {
  public func apply(_ object: UIView) -> Void {
    decoration(object)
  }
}

extension Array where Element == Decorable {
  func apply(_ object: UIView) -> Void {
    self.forEach { $0.decoration(object) }
  }
}
