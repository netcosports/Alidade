import Foundation

public extension NSObjectProtocol {

  static var className: String { return NSStringFromClass(self) }
  var className: String { return type(of: self).className }
}
