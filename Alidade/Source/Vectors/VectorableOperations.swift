//
//  Created by Dmitry Duleba on 3/23/19.
//

import Foundation
import UIKit

// MARK: - SIMD2

public extension SIMD where Scalar == CGFloat, MaskStorage == SIMD2<Scalar.SIMDMaskScalar> {

  var abs: Self { return Self.abs(self) }

  var ceiled: Self { return Self.ceil(self) }

  var floored: Self { return Self.floor(self) }

  func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
    return Self.round(self, rule: rule)
  }

  var length: Scalar { return Self.length(self) }

  var lengthSquared: Scalar { return Self.lengthSquared(self) }

  func clamp(_ min: Scalar, _ max: Scalar) -> Self {
    return Self.clamp(self, min: min, max: max)
  }

  func clamp(_ min: Self, _ max: Self) -> Self {
    return Self.clamp(self, min: min, max: max)
  }

  func crossProduct(_ z: Self) -> (Self, Scalar) {
    return Self.cross(self, z)
  }

  func distance(_ to: Self) -> Scalar {
    return Self.distance(self, to)
  }

  func distanceSquared(_ to: Self) -> Scalar {
    return Self.distanceSquared(self, to)
  }

  func dotProduct(_ z: Self) -> Scalar {
    return Self.dot(self, z)
  }

  // MARK: - Internal

  @inline(__always)
  static internal func abs(_ x: Self) -> Self {
    return Self.init(arrayLiteral: Swift.abs(x[0]), Swift.abs(x[1]))
  }

  @inline(__always)
  static internal func ceil(_ x: Self) -> Self {
    return Self.init(arrayLiteral: Darwin.ceil(NativeType(x[0]).cg), Darwin.ceil(NativeType(x[1])).cg)
  }

  @inline(__always)
  static internal func floor(_ x: Self) -> Self {
    return Self.init(arrayLiteral: Darwin.floor(NativeType(x[0]).cg), Darwin.floor(NativeType(x[1])).cg)
  }

  @inline(__always)
  static internal func round(_ x: Self, rule: FloatingPointRoundingRule) -> Self {
    return Self.init(arrayLiteral: x[0].rounded(rule), x[1].rounded(rule))
  }

  @inline(__always)
  static internal func length(_ x: Self) -> Scalar {
    return dot(x, x).squareRoot()
  }
  @inline(__always)
  static internal func lengthSquared(_ x: Self) -> Scalar {
    return dot(x, x)
  }

  @inline(__always)
  static internal func clamp(_ x: Self, min: Scalar, max: Scalar) -> Self {
    return Self.init(arrayLiteral: x[0].clamp(min, max), x[1].clamp(min, max))
  }

  @inline(__always)
  static internal func clamp(_ x: Self, min: Self, max: Self) -> Self {
    return Self.init(arrayLiteral: x[0].clamp(min[0], max[0]), x[1].clamp(min[1], max[1]))
  }

  // v × w = ( v₂w₃ - v₃w₂, v₃w₁ - v₁w₃, v₁w₂ - v₂w₁)
  @inline(__always)
  static internal func cross(_ x: Self, _ y: Self) -> (Self, Scalar) {
    return (Self.init(arrayLiteral: x[1] * y[2] - x[2] * x[1], x[2] * y[1] - x[1] * y[2]), x[0] * y[1] - x[1] * y[0])
  }

  @inline(__always)
  static internal func distance(_ x: Self, _ y: Self) -> Scalar {
    return (x - y).length
  }

  @inline(__always)
  static internal func distanceSquared(_ x: Self, _ y: Self) -> Scalar {
    return (x - y).lengthSquared
  }

  @inline(__always)
  static internal func dot(_ x: Self, _ y: Self) -> Scalar {
    return x[0] * y[0] + x[1] * y[1]
  }

}

// MARK: - SIMD

// swiftlint:disable identifier_name

public func ~== <T>(lhs: T, rhs: T) -> Bool where T: SIMD, T.Scalar == CGFloat {
  return lhs.isFuzzyEqual(to: rhs)
}

public func ~!= <T>(lhs: T, rhs: T) -> Bool where T: SIMD, T.Scalar == CGFloat {
  return !lhs.isFuzzyEqual(to: rhs)
}

public extension SIMD where Scalar == CGFloat {

  typealias NativeType = CGFloat.NativeType

  func isFuzzyEqual(to value: Self, epsilon: CGFloat = .epsilon) -> Bool {
    for i in 0..<scalarCount {
      if !self[i].isFuzzyEqual(to: value[i], epsilon: epsilon) {
        return false
      }
    }
    return true
  }

}
