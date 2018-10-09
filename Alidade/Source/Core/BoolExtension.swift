import Foundation

public extension Bool {

  @available(iOS, deprecated, message: "Deprecated in swift 4.2")
  static var random: Bool { return random() }
}
