import UIKit
import Foundation

public extension CGSize { var ui: CGSize { return UI.value(self) } }
public extension UIOffset { var ui: UIOffset { return UI.value(self) } }
public extension UIEdgeInsets { var ui: UIEdgeInsets { return UI.value(self) } }
public extension CGPoint { var ui: CGPoint { return UI.value(self) } }

public extension Int { var ui: CGFloat { return UI.value(self) } }
public extension UInt { var ui: CGFloat { return UI.value(self) } }

public extension FloatingPoint where Self == Double { var ui: CGFloat { return UI.value(CGFloat(self)) } }
public extension FloatingPoint where Self == Float { var ui: CGFloat { return UI.value(CGFloat(self)) } }
public extension FloatingPoint where Self == CGFloat { var ui: CGFloat { return UI.value(self) } }

public extension UIFont { var ui: UIFont { return withSize(pointSize.ui) } }

// swiftlint:disable:next type_name
public class UI {

  public static var baseWidths: [UIUserInterfaceIdiom : CGFloat] = [:] {
    didSet {
      scaleFactor = calculateScale()
    }
  }

  public private(set) static var scaleFactor: CGFloat = calculateScale()

  private static func calculateScale() -> CGFloat {
    let size = UIScreen.main.bounds.size
    let width = min(size.width, size.height)
    let idiom = UIDevice.current.userInterfaceIdiom
    let result: CGFloat
    let baseWidth: CGFloat
    switch idiom {
    case .pad: baseWidth = baseWidths[idiom] ?? 1536.0
    case .phone: baseWidth = baseWidths[idiom] ?? 640.0
    default: baseWidth = width
    }
    result = width / baseWidth
    return result
  }

  private init() { }
}

private extension UI {

  static func value(_ value: CGFloat) -> CGFloat {
    let absValue = abs(value)
    let sign = value.sign
    guard absValue > 1.0 else { return value }
    return floor(absValue * scaleFactor) * sign
  }

  static func value(_ value: Int) -> CGFloat {
    return UI.value(CGFloat(value))
  }

  static func value(_ value: UInt) -> CGFloat {
    return UI.value(CGFloat(value))
  }

  static func value(_ value: CGSize) -> CGSize {
    return (value * scaleFactor).ceiled
  }

  static func value(_ value: CGPoint) -> CGPoint {
    return (value * scaleFactor).ceiled
  }

  static func value(_ value: UIEdgeInsets) -> UIEdgeInsets {
    return value * scaleFactor
  }

  static func value(_ value: UIOffset) -> UIOffset {
    let offset = UIOffset(horizontal: value.horizontal * scaleFactor,
                          vertical: value.vertical * scaleFactor)
    return offset
  }
}
