//
//  GeometryExtensions.swift
//
//  Created by Vladimir Burdukov on 12/22/16.
//  Copyright © 2016 NetcoSports. All rights reserved.
//

import UIKit

public extension CGAffineTransform {

  var translation: CGPoint {
    return CGPoint(x: tx, y: ty)
  }
}

public func + (left: CGAffineTransform, right: CGAffineTransform) -> CGAffineTransform {
  return left.concatenating(right)
}

public prefix func ! (transform: CGAffineTransform) -> CGAffineTransform {
  return transform.inverted()
}

public func << (left: CGRect, right: CGAffineTransform) -> CGRect {
  return left.applying(right)
}

// MARK: - CGPoint

extension CGPoint {

  func diff(_ other: CGPoint) -> CGPoint {
    return CGPoint(x: x - other.x, y: y - other.y)
  }

  func invert() -> CGPoint {
    return self * -1.0
  }

  func multiply(_ multiplier: CGFloat) -> CGPoint {
    return CGPoint(x: x * multiplier, y: y * multiplier)
  }

  public func isFuzzyEqual(to point: CGPoint, epsilon: CGFloat = .epsilon) -> Bool {
    return point.x.isFuzzyEqual(to: x, epsilon: epsilon) && point.y.isFuzzyEqual(to: y, epsilon: epsilon)
  }
}

public func << (left: CGPoint, right: CGAffineTransform) -> CGPoint {
  return left.applying(right)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return left.diff(right)
}

public prefix func - (point: CGPoint) -> CGPoint {
  return point.invert()
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
  return left.multiply(right)
}

public func * (left: CGPoint, right: Double) -> CGPoint {
  return left.multiply(CGFloat(right))
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
  return left * (1.0 / right)
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

// MARK: - UIEdgeInsets

public extension UIEdgeInsets {

  static func top(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: size, left: 0, bottom: 0, right: 0)
  }

  static func left(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: size, bottom: 0, right: 0)
  }

  static func bottom(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: size, right: 0)
  }

  static func right(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: size)
  }

  static func vertical(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: size, left: 0, bottom: size, right: 0)
  }

  static func horizontal(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: size, bottom: 0, right: size)
  }

  static func all(_ size: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
  }

  func top(_ size: CGFloat) -> UIEdgeInsets {
    var other = self
    other.top = size
    return other
  }

  func left(_ size: CGFloat) -> UIEdgeInsets {
    var other = self
    other.left = size
    return other
  }

  func bottom(_ size: CGFloat) -> UIEdgeInsets {
    var other = self
    other.bottom = size
    return other
  }

  func right(_ size: CGFloat) -> UIEdgeInsets {
    var other = self
    other.right = size
    return other
  }

  func vertical(_ size: CGFloat) -> UIEdgeInsets {
    var other = self
    other.top = size
    other.bottom = size
    return other
  }

  func horizontal(_ size: CGFloat) -> UIEdgeInsets {
    var other = self
    other.left = size
    other.right = size
    return other
  }

  var inverted: UIEdgeInsets {
    return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
  }

  func inset(rect: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(rect, self)
  }

  func inset(size: CGSize) -> CGSize {
    let rect = CGRect(origin: .zero, size: size)
    return UIEdgeInsetsInsetRect(rect, self).size
  }

}

prefix func - (insets: UIEdgeInsets) -> UIEdgeInsets {
  return insets * CGFloat(-1.0)
}

func * (left: UIEdgeInsets, right: CGFloat) -> UIEdgeInsets {
  return UIEdgeInsets(top: left.top * right, left: left.left * right,
                      bottom: left.bottom * right, right: left.right * right)
}

public func / (left: UIEdgeInsets, right: CGFloat) -> UIEdgeInsets {
  return left * (1.0 / right)
}

public func + (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
  return UIEdgeInsets(
    top: left.top + right.top,
    left: left.left + right.left,
    bottom: left.bottom + right.bottom,
    right: left.right + right.right
  )
}

public func - (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
  return left + (-right)
}

// MARK: - CGSize

public extension CGSize {

  public var pointValue: CGPoint { return CGPoint(x: width, y: height) }
}

public func * (left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width * right, height: left.height * right)
}

public func * (left: CGFloat, right: CGSize) -> CGSize {
  return right * left
}

public func * (left: CGSize, right: Double) -> CGSize {
  return CGSize(width: left.width * CGFloat(right), height: left.height * CGFloat(right))
}

public func * (left: Double, right: CGSize) -> CGSize {
  return right * left
}

public func / (left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width / right, height: left.height / right)
}

public func / (left: CGSize, right: Double) -> CGSize {
  return CGSize(width: left.width / CGFloat(right), height: left.height / CGFloat(right))
}
