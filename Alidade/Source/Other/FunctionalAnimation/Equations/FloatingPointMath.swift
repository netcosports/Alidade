//    The MIT License (MIT)
//    
//    Copyright (c) 2014 Dan Kogai
//    
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//    
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//    
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//    
//    FloatingPointMath.swift
//
//    Copyright (c) 2014 Dan Kogai. All rights reserved.
//

import Foundation
import UIKit

protocol FloatingPointMath {

  init(_: Double)              // BinaryFloatingPoint already has one

  var asDouble: Double { get } // you have to add it yourself

  static var epsilon: Self { get }

}

extension Double: FloatingPointMath {

  static let epsilon: Double = 0x1p-52

  var asDouble: Double { return self }

  static func acos(_ x: Double) -> Double { return Foundation.acos(x) }
  static func asin(_ x: Double) -> Double { return Foundation.asin(x) }
  static func atan(_ x: Double) -> Double { return Foundation.atan(x) }
  static func acosh(_ x: Double) -> Double { return Foundation.acosh(x) }
  static func asinh(_ x: Double) -> Double { return Foundation.asinh(x) }
  static func atanh(_ x: Double) -> Double { return Foundation.atanh(x) }
  static func cbrt(_ x: Double) -> Double { return Foundation.cbrt(x) }
  static func cos(_ x: Double) -> Double { return Foundation.cos(x) }
  static func cosh(_ x: Double) -> Double { return Foundation.cosh(x) }
  static func exp(_ x: Double) -> Double { return Foundation.exp(x) }
  static func exp2(_ x: Double) -> Double { return Foundation.exp2(x) }
  static func expm1(_ x: Double) -> Double { return Foundation.expm1(x) }
  static func log(_ x: Double) -> Double { return Foundation.log(x) }
  static func log2(_ x: Double) -> Double { return Foundation.log2(x) }
  static func log10(_ x: Double) -> Double { return Foundation.log10(x) }
  static func log1p(_ x: Double) -> Double { return Foundation.log1p(x) }
  static func sin(_ x: Double) -> Double { return Foundation.sin(x) }
  static func sinh(_ x: Double) -> Double { return Foundation.sinh(x) }
  static func sqrt(_ x: Double) -> Double { return Foundation.sqrt(x) }
  static func tan(_ x: Double) -> Double { return Foundation.tan(x) }
  static func tanh(_ x: Double) -> Double { return Foundation.tanh(x) }
  static func atan2(_ y: Double, _ x: Double) -> Double { return Foundation.atan2(y, x) }
  static func hypot(_ x: Double, _ y: Double) -> Double { return Foundation.hypot(x, y) }
  static func pow(_ x: Double, _ y: Double) -> Double { return Foundation.pow(x, y) }

}

extension Float: FloatingPointMath {

  static let epsilon: Float = 0x1p-23

  var asDouble: Double { return Double(self) }

}

extension CGFloat: FloatingPointMath {

  var asDouble: Double { return Double(self) }

}

extension FloatingPointMath {

  static func acos(_ x: Self) -> Self { return Self(Foundation.acos (x.asDouble)) }
  static func acosh(_ x: Self) -> Self { return Self(Foundation.acosh(x.asDouble)) }
  static func asin(_ x: Self) -> Self { return Self(Foundation.asin (x.asDouble)) }
  static func asinh(_ x: Self) -> Self { return Self(Foundation.asinh(x.asDouble)) }
  static func atan(_ x: Self) -> Self { return Self(Foundation.atan (x.asDouble)) }
  static func atanh(_ x: Self) -> Self { return Self(Foundation.atanh(x.asDouble)) }
  static func cos(_ x: Self) -> Self { return Self(Foundation.cos  (x.asDouble)) }
  static func cbrt(_ x: Self) -> Self { return Self(Foundation.cbrt (x.asDouble)) }
  static func cosh(_ x: Self) -> Self { return Self(Foundation.cosh (x.asDouble)) }
  static func exp(_ x: Self) -> Self { return Self(Foundation.exp  (x.asDouble)) }
  static func exp2(_ x: Self) -> Self { return Self(Foundation.exp2 (x.asDouble)) }
  static func expm1(_ x: Self) -> Self { return Self(Foundation.expm1(x.asDouble)) }
  static func log(_ x: Self) -> Self { return Self(Foundation.log  (x.asDouble)) }
  static func log2(_ x: Self) -> Self { return Self(Foundation.log2 (x.asDouble)) }
  static func log10(_ x: Self) -> Self { return Self(Foundation.log10(x.asDouble)) }
  static func log1p(_ x: Self) -> Self { return Self(Foundation.log1p(x.asDouble)) }
  static func sin(_ x: Self) -> Self { return Self(Foundation.sin  (x.asDouble)) }
  static func sinh(_ x: Self) -> Self { return Self(Foundation.sinh (x.asDouble)) }
  static func sqrt(_ x: Self) -> Self { return Self(Foundation.sqrt (x.asDouble)) }
  static func tan(_ x: Self) -> Self { return Self(Foundation.tan  (x.asDouble)) }
  static func tanh(_ x: Self) -> Self { return Self(Foundation.tanh (x.asDouble)) }
  static func atan2(_ x: Self, _ y: Self) -> Self { return Self(Foundation.atan2(x.asDouble, y.asDouble)) }
  static func hypot(_ x: Self, _ y: Self) -> Self { return Self(Foundation.hypot(x.asDouble, y.asDouble)) }
  static func pow(_ x: Self, _ y: Self) -> Self { return Self(Foundation.pow  (x.asDouble, y.asDouble)) }

  var acos: Self { return Self.acos(self) }
  var acosh: Self { return Self.acosh(self) }
  var asin: Self { return Self.asin(self) }
  var asinh: Self { return Self.asinh(self) }
  var atan: Self { return Self.atan(self) }
  var atanh: Self { return Self.atanh(self) }
  var cos: Self { return Self.cos(self) }
  var cbrt: Self { return Self.cbrt(self) }
  var cosh: Self { return Self.cosh(self) }
  var exp: Self { return Self.exp(self) }
  var exp2: Self { return Self.exp2(self) }
  var expm1: Self { return Self.expm1(self) }
  var log: Self { return Self.log(self) }
  var log2: Self { return Self.log2(self) }
  var log10: Self { return Self.log10(self) }
  var log1p: Self { return Self.log1p(self) }
  var sin: Self { return Self.sin(self) }
  var sinh: Self { return Self.sinh(self) }
  var sqrt: Self { return Self.sqrt(self) }
  var tan: Self { return Self.tan(self) }
  var tanh: Self { return Self.tanh(self) }
  func atan2(_ z: Self) -> Self { return Self.atan2(self, z) }
  func hypot(_ z: Self) -> Self { return Self.hypot(self, z) }
  func pow(_ z: Self) -> Self { return Self.pow(self, z) }

}
