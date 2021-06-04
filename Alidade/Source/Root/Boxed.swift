//
//  Created by Dmitry Duleba on 10/24/17.
//

public class Boxed<T> {

  public var value: T?

  public init(_ value: T? = nil) {
    self.value = value
  }

  public func flatMap<U>(_ transform: (T) -> U?) -> U? {
    return value.flatMap(transform)
  }
}
