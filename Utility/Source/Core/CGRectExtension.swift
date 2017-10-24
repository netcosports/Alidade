import Foundation

public extension CGRect {

  public var hashValue: Int { return origin.hashValue ^ size.hashValue }
}
