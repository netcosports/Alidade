//
//  UIScalable.swift
//  Alidade
//
//  Created by Dmitry Duleba on 11/13/18.
//

import Foundation

// MARK: - UIScalable

public protocol UIScalable {

  associatedtype UIValue

  var ui: UIValue { get }

  func uiValue(for intent: UI.Intent) -> UIValue
}

extension Int: UIScalable {
  public typealias UIValue = CGFloat
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension UInt: UIScalable {
  public typealias UIValue = CGFloat
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension CGFloat: UIScalable {
  public typealias UIValue = CGFloat
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension Double: UIScalable {
  public typealias UIValue = CGFloat
  public var ui: UIValue { return UI.value(cgFloat, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(cgFloat, for: intent) }
}

extension Float: UIScalable {
  public typealias UIValue = CGFloat
  public var ui: UIValue { return UI.value(cgFloat, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(cgFloat, for: intent) }
}

extension CGPoint: UIScalable {
  public typealias UIValue = CGPoint
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension CGSize: UIScalable {
  public typealias UIValue = CGSize
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension UIOffset: UIScalable {
  public typealias UIValue = UIOffset
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension UIEdgeInsets: UIScalable {
  public typealias UIValue = UIEdgeInsets
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

extension UIFont: UIScalable {
  public typealias UIValue = UIFont
  public var ui: UIValue { return UI.value(self, for: .general) }
  public func uiValue(for intent: UI.Intent) -> UIValue { return UI.value(self, for: intent) }
}

// MARK: - UI.Private

fileprivate extension UI {

  static func value(_ value: CGFloat, for intent: Intent) -> CGFloat {
    let absValue = abs(value)
    let sign = value.sign
    guard absValue > 1.0 else { return value }
    return floor(absValue * scaleFactor(for: intent)) * sign
  }

  static func value(_ value: Int, for intent: Intent) -> CGFloat {
    return UI.value(CGFloat(value), for: intent)
  }

  static func value(_ value: UInt, for intent: Intent) -> CGFloat {
    return UI.value(CGFloat(value), for: intent)
  }

  static func value(_ value: CGSize, for intent: Intent) -> CGSize {
    let scaleFactor = self.scaleFactor(for: intent)
    return CGSize(width: value.width * scaleFactor,
                  height: value.height * scaleFactor).ceiled
  }

  static func value(_ value: CGPoint, for intent: Intent) -> CGPoint {
    let scaleFactor = self.scaleFactor(for: intent)
    return CGPoint(x: value.x * scaleFactor,
                   y: value.y * scaleFactor).ceiled
  }

  static func value(_ value: UIEdgeInsets, for intent: Intent) -> UIEdgeInsets {
    let scaleFactor = self.scaleFactor(for: intent)
    return UIEdgeInsets(top: value.top * scaleFactor,
                        left: value.left * scaleFactor,
                        bottom: value.bottom * scaleFactor,
                        right: value.right * scaleFactor)
  }

  static func value(_ value: UIOffset, for intent: Intent) -> UIOffset {
    let scaleFactor = self.scaleFactor(for: intent)
    let offset = UIOffset(horizontal: value.horizontal * scaleFactor,
                          vertical: value.vertical * scaleFactor)
    return offset
  }

  static func value(_ value: UIFont, for intent: Intent) -> UIFont {
    let fontSize = UI.value(value.pointSize, for: intent)
    return value.withSize(fontSize)
  }

}
