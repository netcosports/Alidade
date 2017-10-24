import Foundation

public extension CGSize {

  public var pointValue: CGPoint { return CGPoint(x: width, y: height) }

  public var rectValue: CGRect { return CGRect(origin: .zero, size: self) }

  public var hashValue: Int { return width.hashValue ^ height.hashValue }

  public var rounded: CGSize { return CGSize(width: width.rounded(), height: height.rounded()) }

  public var ceiled: CGSize { return CGSize(width: ceil(width), height: ceil(height)) }

  public var floored: CGSize { return CGSize(width: floor(width), height: floor(height)) }
}
