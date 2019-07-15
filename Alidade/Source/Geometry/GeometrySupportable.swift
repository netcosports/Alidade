//
//  Created by Dmitry Duleba on 3/15/19.
//

import UIKit

public protocol GeometrySupportable { }

public struct GeometryExtension<Base> {

  let base: Base

  init(_ base: Base) {
    self.base = base
  }

}

public extension GeometrySupportable {

  var geometry: GeometryExtension<Self> {
    return GeometryExtension(self)
  }

}
