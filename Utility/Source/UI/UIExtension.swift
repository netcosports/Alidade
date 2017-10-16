import UIKit
import Foundation

public extension CGSize { var ui: CGSize { return UI.value(self) } }
public extension UIOffset { var ui: UIOffset { return UI.value(self) } }
public extension UIEdgeInsets { var ui: UIEdgeInsets { return UI.value(self) } }
public extension CGPoint { var ui: CGPoint { return UI.value(self) } }

public extension Int { var ui: CGFloat { return UI.value(self) } }

public extension FloatingPoint where Self == Double { var ui: CGFloat { return UI.value(CGFloat(self)) } }
public extension FloatingPoint where Self == Float { var ui: CGFloat { return UI.value(CGFloat(self)) } }
public extension FloatingPoint where Self == CGFloat { var ui: CGFloat { return UI.value(self) } }

public extension UIFont { var ui: UIFont { return withSize(pointSize.ui) } }

// swiftlint:disable:next type_name
public class UI {

  public static let scaleFactor: CGFloat = {
    let size = UIScreen.main.bounds.size
    let width = min(size.width, size.height)
    let idiom = UIDevice.current.userInterfaceIdiom
    let result: CGFloat
    switch (idiom, width) {
    case (.pad, _)  : result = width / 1536.0
    default         : result = width / 640.0
    }
    return result
  }()

  private init() { }
}

fileprivate extension UI {

  static func value(_ value: CGFloat) -> CGFloat {
    let absValue = abs(value)
    let sign: CGFloat = value < 0.0 ? -1.0 : 1.0
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
    let w = ceil(value.width * scaleFactor)
    let h = ceil(value.height * scaleFactor)
    let size = CGSize(width: w, height: h)
    return size
  }

  static func value(_ value: CGPoint) -> CGPoint {
    let x = ceil(value.x * scaleFactor)
    let y = ceil(value.y * scaleFactor)
    let point = CGPoint(x: x, y: y)
    return point
  }

  static func value(_ value: UIEdgeInsets) -> UIEdgeInsets {
    let t = value.top * scaleFactor
    let l = value.left * scaleFactor
    let b = value.bottom * scaleFactor
    let r = value.right * scaleFactor
    let inset = UIEdgeInsets(top: t, left: l, bottom: b, right: r)
    return inset
  }

  static func value(_ value: UIOffset) -> UIOffset {
    let h = value.horizontal * scaleFactor
    let v = value.vertical * scaleFactor
    let offset = UIOffset(horizontal: h, vertical: v)
    return offset
  }
}

// MARK: - Device

public extension UI {

  public struct Device {
    let phone: CGFloat
    let pad: CGFloat

    public init(_ phone: CGFloat, _ pad: CGFloat) {
      self.phone = phone
      self.pad = pad
    }

    public var value: CGFloat { return UI.Device.value(phone, pad) }
    public var ui: CGFloat { return value.ui }
  }
}

public extension UI.Device {

  public static func value<T>(_ phone: T, _ pad: T) -> T {
    return UIDevice.current.userInterfaceIdiom == .pad ? pad : phone
  }
}

public extension UI.Device {

  public enum System {

    case iOS9
    case iOS10
    case iOS11

    public static let current: System = {
      if #available(iOS 11, *) {
        return System.iOS11
      }
      if #available(iOS 10, *) {
        return System.iOS10
      }
      return System.iOS9
    }()
  }
}

// MARK: - UI.Size

public extension UI {

  public enum Size {

    public static let statusBar = 20.0 + cornerRadius
    public static let navigationBar = 44.0 + statusBar

    public static let tabBar: CGFloat = {
      switch UIScreen.main.nativeBounds.height {
      case 2436:
        return 83.0
      default:
        return 49.0
      }
    }()

    public static let cornerRadius: CGFloat = {
      switch UIScreen.main.nativeBounds.height {
      case 2436:
        return 24.0
      default:
        return 0.0
      }
    }()
  }
}
