//
//  Created by Dmitry Duleba on 4/5/19.
//

import Foundation
import UIKit

public protocol VectorableScalarConvertible {

  // swiftlint:disable:next identifier_name
  var cg: CGFloat { get }

}

extension Int: VectorableScalarConvertible { }

extension Float: VectorableScalarConvertible { }

extension Double: VectorableScalarConvertible { }

public extension SIMD where Scalar == CGFloat {

  typealias OperatorType = VectorableScalarConvertible

  /// Returns a vector mask with the result of a pointwise equality comparison.
  static func .== (lhs: OperatorType, rhs: Self) -> SIMDMask<Self.MaskStorage> {
    return lhs.cg .== rhs
  }

  /// Returns a vector mask with the result of a pointwise inequality comparison.
  static func .!= (lhs: OperatorType, rhs: Self) -> SIMDMask<Self.MaskStorage> {
    return lhs.cg .!= rhs
  }

  /// Returns a vector mask with the result of a pointwise equality comparison.
  static func .== (lhs: Self, rhs: OperatorType) -> SIMDMask<Self.MaskStorage> {
    return lhs .== rhs.cg
  }

  /// Returns a vector mask with the result of a pointwise inequality comparison.
  static func .!= (lhs: Self, rhs: OperatorType) -> SIMDMask<Self.MaskStorage> {
    return lhs .!= rhs.cg
  }

  // MARK: - Comparable

  /// Returns a vector mask with the result of a pointwise less than comparison.
  static func .< (lhs: OperatorType, rhs: Self) -> SIMDMask<Self.MaskStorage> {
    return lhs.cg .< rhs
  }

  /// Returns a vector mask with the result of a pointwise less than or equal
  /// comparison.
  static func .<= (lhs: OperatorType, rhs: Self) -> SIMDMask<Self.MaskStorage> {
    return lhs.cg .<= rhs
  }

  /// Returns a vector mask with the result of a pointwise greater than or
  /// equal comparison.
  static func .>= (lhs: OperatorType, rhs: Self) -> SIMDMask<Self.MaskStorage> {
    return lhs.cg .>= rhs
  }

  /// Returns a vector mask with the result of a pointwise greater than
  /// comparison.
  static func .> (lhs: OperatorType, rhs: Self) -> SIMDMask<Self.MaskStorage> {
    return lhs.cg .> rhs
  }

  /// Returns a vector mask with the result of a pointwise less than comparison.
  static func .< (lhs: Self, rhs: OperatorType) -> SIMDMask<Self.MaskStorage> {
    return lhs .< rhs.cg
  }

  /// Returns a vector mask with the result of a pointwise less than or equal
  /// comparison.
  static func .<= (lhs: Self, rhs: OperatorType) -> SIMDMask<Self.MaskStorage> {
    return lhs .<= rhs.cg
  }

  /// Returns a vector mask with the result of a pointwise greater than or
  /// equal comparison.
  static func .>= (lhs: Self, rhs: OperatorType) -> SIMDMask<Self.MaskStorage> {
    return lhs .>= rhs.cg
  }

  /// Returns a vector mask with the result of a pointwise greater than
  /// comparison.
  static func .> (lhs: Self, rhs: OperatorType) -> SIMDMask<Self.MaskStorage> {
    return lhs .> rhs.cg
  }

  // MARK: - FloatingPoint

  static func + (lhs: OperatorType, rhs: Self) -> Self {
    return lhs.cg + rhs
  }

  static func - (lhs: OperatorType, rhs: Self) -> Self {
    return lhs.cg - rhs
  }

  static func * (lhs: OperatorType, rhs: Self) -> Self {
    return lhs.cg * rhs
  }

  static func / (lhs: OperatorType, rhs: Self) -> Self {
    return lhs.cg / rhs
  }

  static func + (lhs: Self, rhs: OperatorType) -> Self {
    return lhs + rhs.cg
  }

  static func - (lhs: Self, rhs: OperatorType) -> Self {
    return lhs - rhs.cg
  }

  static func * (lhs: Self, rhs: OperatorType) -> Self {
    return lhs * rhs.cg
  }

  static func / (lhs: Self, rhs: OperatorType) -> Self {
    return lhs / rhs.cg
  }

  static func += (lhs: inout Self, rhs: OperatorType) {
    lhs += rhs.cg
  }

  static func -= (lhs: inout Self, rhs: OperatorType) {
    lhs -= rhs.cg
  }

  static func *= (lhs: inout Self, rhs: OperatorType) {
    lhs *= rhs.cg
  }

  static func /= (lhs: inout Self, rhs: OperatorType) {
    lhs /= rhs.cg
  }

  func addingProduct(_ lhs: OperatorType, _ rhs: Self) -> Self {
    return addingProduct(lhs.cg, rhs)
  }

  func addingProduct(_ lhs: Self, _ rhs: OperatorType) -> Self {
    return addingProduct(lhs, rhs.cg)
  }

  mutating func addProduct(_ lhs: OperatorType, _ rhs: Self) {
    addProduct(lhs.cg, rhs)
  }

  mutating func addProduct(_ lhs: Self, _ rhs: OperatorType) {
    addProduct(lhs, rhs.cg)
  }

}
