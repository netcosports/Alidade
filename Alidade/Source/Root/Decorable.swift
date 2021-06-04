//
//  Created by Sergey Krumin on 2/18/20.
//

import UIKit

public typealias Decoration<View> = (View) -> Void

public protocol Decorable {
  associatedtype View
  var decoration: Decoration<View> { get }
}

extension Decorable {
  public func apply<T>(_ view: T) where T == View {
    decoration(view)
  }
}
