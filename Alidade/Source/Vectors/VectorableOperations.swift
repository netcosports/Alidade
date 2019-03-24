//
//  VectorableOperations.swift
//  Alidade
//
//  Created by Dmitry Duleba on 3/23/19.
//

import Foundation
import simd

public extension SIMD where Scalar == CGFloat, MaskStorage == SIMD2<Scalar.SIMDMaskScalar> {

  @inline(__always)
  internal func abs(_ x: Self) -> Self {
    return Self.init(arrayLiteral: Swift.abs(self[0]), Swift.abs(self[1]))
  }

  var abs: Self { return abs(self) }

}

///// Elementwise absolute value of a vector.  The result is a vector of the same
///// length with all elements positive.
//public func abs(_ x: float2) -> float2

///// Each element of the result is the smallest integral value greater than or
///// equal to the corresponding element of the input.
//public func ceil(_ x: float2) -> float2

///// Each component of the result is the corresponding element of `x` clamped to
///// the range formed by the corresponding elements of `min` and `max`.  Any
///// lanes of `x` that contain NaN will end up with the `min` value.
//public func clamp(_ x: float2, min: float2, max: float2) -> float2

///// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
///// NaN, the corresponding lane of the result is `min`.
//public func clamp(_ x: float2, min: Float, max: Float) -> float2

///// Interprets two two-dimensional vectors as three-dimensional vectors in the
///// xy-plane and computes their cross product, which lies along the z-axis.
//public func cross(_ x: float2, _ y: float2) -> float3

///// Distance between `x` and `y`.
//public func distance(_ x: float2, _ y: float2) -> Float

///// Distance between `x` and `y`, squared.
//public func distance_squared(_ x: float2, _ y: float2) -> Float

///// Dot product of `x` and `y`.
//public func dot(_ x: float2, _ y: float2) -> Float
