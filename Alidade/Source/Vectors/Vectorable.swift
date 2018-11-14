//
//  Vectorable.swift
//  Utility
//
//  Created by Dmitry Duleba on 1/6/18.
//

import Foundation
import UIKit

//swiftlint:disable identifier_name file_length
public protocol Vectorable {

  static var length: Int { get }

  var vector: [CGFloat] { get set }

  init()
}

public extension Vectorable {

  public init(_ value: Vector1D) {
    self.init(value.x)
  }

  public init(_ values: [Vector1D]) {
    self.init()
    vector = values.map { $0.x }
  }

  public init(_ values: Vector1D...) {
    self.init(values)
  }

  fileprivate init(_ cgFloatValue: CGFloat) {
    self.init()
    vector = .init(repeating: cgFloatValue, count: Self.length)
  }
}

// MARK: - Vector1D

public protocol Vector1D: Vectorable {

  var x: CGFloat { get set }
}

extension Vector1D {

  public static var length: Int { return 1 }

  public var vector: [CGFloat] {
    get { return [x] }
    set { x = newValue[0] }
  }

  public init(x: CGFloat) {
    self.init()
    self.x = x
  }
}

// MARK: - Vector2D

public protocol Vector2D: Vector1D {

  var y: CGFloat { get set }
}

extension Vector2D {

  public static var length: Int { return 2 }

  public var vector: [CGFloat] {
    get { return [x, y] }
    set { x = newValue[0]; y = newValue[1] }
  }

  public init(x: CGFloat, y: CGFloat) {
    self.init()
    self.x = x
    self.y = y
  }
}

// MARK: - Vector3D

public protocol Vector3D: Vector2D {

  var z: CGFloat { get set }
}

public extension Vector3D {

  public static var length: Int { return 3 }

  public var vector: [CGFloat] {
    get { return [x, y, z] }
    set { x = newValue[0]; y = newValue[1]; z = newValue[2] }
  }

  public init(x: CGFloat, y: CGFloat, z: CGFloat) {
    self.init()
    self.x = x
    self.y = y
    self.z = z
  }
}

// MARK: - 1D

extension CGFloat: Vector1D {

  public var x: CGFloat {
    get { return self }
    set { self = newValue }
  }
}

extension Float: Vector1D {

  public var x: CGFloat {
    get { return CGFloat(self) }
    set { self = Float(newValue) }
  }
}

extension Double: Vector1D {

  public var x: CGFloat {
    get { return CGFloat(self) }
    set { self = Double(newValue) }
  }
}

extension Int: Vector1D {

  public var x: CGFloat {
    get { return CGFloat(self) }
    set { self = Int(newValue) }
  }
}

extension UInt: Vector1D {

  public var x: CGFloat {
    get { return CGFloat(self) }
    set { self = UInt(newValue) }
  }
}

// MARK: - 2D

extension CGPoint: Vector2D { }

extension CGVector: Vector2D {

  public var x: CGFloat {
    get { return dx }
    set { dx = newValue }
  }

  public var y: CGFloat {
    get { return dy }
    set { dy = newValue }
  }
}

extension CGSize: Vector2D {

  public var x: CGFloat {
    get { return width }
    set { width = newValue }
  }

  public var y: CGFloat {
    get { return height }
    set { height = newValue }
  }
}

extension UIOffset: Vector2D {

  public var x: CGFloat {
    get { return horizontal }
    set { horizontal = newValue }
  }

  public var y: CGFloat {
    get { return vertical }
    set { vertical = newValue }
  }
}

// MARK: - 3D

// MARK: - N-dimensional

extension CGRect: Vectorable {

  public static var length: Int { return 4 }

  public var vector: [CGFloat] {
    get { return [origin.x, origin.y, size.width, size.height] }
    set {
      origin.x = newValue[0]
      origin.y = newValue[1]
      size.width = newValue[2]
      size.height = newValue[3]
    }
  }
}

extension UIEdgeInsets: Vectorable {

  public static var length: Int { return 4 }

  public var vector: [CGFloat] {
    get { return [top, left, bottom, right] }
    set {
      top = newValue[0]
      left = newValue[1]
      bottom = newValue[2]
      right = newValue[3]
    }
  }
}

// MARK: - 1-to-1 Operations

public func + <T, U>(lhs: T, rhs: U) -> T where T: Vector1D, U: Vector1D {
  return .init(x: lhs.x + rhs.x)
}

public func - <T, U>(lhs: U, rhs: T) -> T where T: Vector1D, U: Vector1D {
  return .init(x: lhs.x - rhs.x)
}

public func * <T, U>(lhs: U, rhs: T) -> T where T: Vector1D, U: Vector1D {
  return .init(x: lhs.x * rhs.x)
}

public func / <T, U>(lhs: U, rhs: T) -> T where T: Vector1D, U: Vector1D {
  return .init(x: lhs.x / rhs.x)
}

// MARK: - 2 prefix Operations

public prefix func - <T>(lhs: T) -> T where T: Vector2D {
  return .init(x: -lhs.x, y: -lhs.y)
}

// MARK: - 2-to-1 Operations

public func + <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x + rhs.x, y: lhs.y + rhs.x)
}

public func + <T, U>(lhs: U, rhs: T) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x + rhs.x, y: lhs.x + rhs.y)
}

public func - <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x - rhs.x, y: lhs.y - rhs.x)
}

public func - <T, U>(lhs: U, rhs: T) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x - rhs.x, y: lhs.x - rhs.y)
}

public func * <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x * rhs.x, y: lhs.y * rhs.x)
}

public func * <T, U>(lhs: U, rhs: T) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x * rhs.x, y: lhs.x * rhs.y)
}

public func / <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x / rhs.x, y: lhs.y / rhs.x)
}

public func / <T, U>(lhs: U, rhs: T) -> T where T: Vector2D, U: Vector1D {
  return .init(x: lhs.x / rhs.x, y: lhs.x / rhs.y)
}

// MARK: - 2-to-2 Operations

public func + <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector2D {
  return .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector2D {
  return .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func * <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector2D {
  return .init(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func / <T, U>(lhs: T, rhs: U) -> T where T: Vector2D, U: Vector2D {
  return .init(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

// MARK: - 3 prefix Operations

public prefix func - <T>(lhs: T) -> T where T: Vector3D {
  return .init(x: -lhs.x, y: -lhs.y, z: -lhs.z)
}

// MARK: - 3-to-1 Operations

public func + <T, U>(lhs: T, rhs: U) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x + rhs.x, y: lhs.y + rhs.x, z: lhs.z + rhs.x)
}

public func + <T, U>(lhs: U, rhs: T) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x + rhs.x, y: lhs.x + rhs.y, z: lhs.x + rhs.z)
}

public func - <T, U>(lhs: T, rhs: U) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x - rhs.x, y: lhs.y - rhs.x, z: lhs.z - rhs.x)
}

public func - <T, U>(lhs: U, rhs: T) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x - rhs.x, y: lhs.x - rhs.y, z: lhs.x - rhs.z)
}

public func * <T, U>(lhs: T, rhs: U) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x * rhs.x, y: lhs.y * rhs.x, z: lhs.z * rhs.x)
}

public func * <T, U>(lhs: U, rhs: T) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x * rhs.x, y: lhs.x * rhs.y, z: lhs.x * rhs.z)
}

public func / <T, U>(lhs: T, rhs: U) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x / rhs.x, y: lhs.y / rhs.x, z: lhs.z / rhs.x)
}

public func / <T, U>(lhs: U, rhs: T) -> T where T: Vector3D, U: Vector1D {
  return .init(x: lhs.x / rhs.x, y: lhs.x / rhs.y, z: lhs.x / rhs.z)
}

// MARK: - n prefix Operations

public prefix func - <T>(lhs: T) -> T where T: Vectorable {
  return n1Operation(lhs, -1) { $0 * $1 }
}

// MARK: - n-to-1 Operations

private typealias Transform = (CGFloat, CGFloat) -> CGFloat
private func n1Operation<T, U>(_ lhs: T, _ rhs: U, transform: Transform) -> T where T: Vectorable, U: Vector1D {
  let rhs = T.init(rhs.x)
  return nnOperation(lhs, rhs, transform: transform)
}

public func + <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(lhs, rhs) { $0 + $1 }
}

public func + <T, U>(lhs: U, rhs: T) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(rhs, lhs) { $1 + $0 }
}

public func - <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(lhs, rhs) { $0 - $1 }
}

public func - <T, U>(lhs: U, rhs: T) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(rhs, lhs) { $1 - $0 }
}

public func * <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(lhs, rhs) { $0 * $1 }
}

public func * <T, U>(lhs: U, rhs: T) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(rhs, lhs) { $1 * $0 }
}

public func / <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(lhs, rhs) { $0 / $1 }
}

public func / <T, U>(lhs: U, rhs: T) -> T where T: Vectorable, U: Vector1D {
  return n1Operation(rhs, lhs) { $1 / $0 }
}

// MARK: - n-to-n Operations

private func nnOperation<T, U>(_ lhs: T, _ rhs: U, transform: Transform) -> T where T: Vectorable, U: Vectorable {
  assert(T.length == U.length, "vectors lengths not equal: \(T.length) != \(U.length)")

  var result = T.init()
  result.vector = zip(lhs.vector, rhs.vector).map(transform)
  return result
}

public func + <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vectorable {
  return nnOperation(lhs, rhs) { $0 + $1 }
}

public func - <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vectorable {
  return nnOperation(lhs, rhs) { $0 - $1 }
}

public func * <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vectorable {
  return nnOperation(lhs, rhs) { $0 * $1 }
}

public func / <T, U>(lhs: T, rhs: U) -> T where T: Vectorable, U: Vectorable {
  return nnOperation(lhs, rhs) { $0 / $1 }
}
//swiftlint:enable identifier_name file_length
