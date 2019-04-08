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
//    ComplexNumeric.swift
//

#if os(Linux)
import Glibc
#else
import Darwin
#endif

// swiftlint:disable shorthand_operator identifier_name file_length

public protocol ComplexNumeric: Hashable {

  associatedtype Element: SignedNumeric

  var real: Element { get set }
  var imag: Element { get set }

  init(real: Element, imag: Element)
}

extension ComplexNumeric {

  init(_ r: Element, _ i: Element) {
    self.init(real: r, imag: i)
  }

  init(_ r: Element) {
    self.init(r, 0)
  }

  var i: Self {
    return Self(-imag, real)
  }

  // +
  static prefix func + (_ z: Self) -> Self {
    return z
  }

  static func + (_ lhs: Self, _ rhs: Self) -> Self {
    return Self(lhs.real + rhs.real, lhs.imag + rhs.imag)
  }

  static func + (_ lhs: Self, _ rhs: Element) -> Self {
    return Self(lhs.real + rhs, lhs.imag)
  }

  static func + (_ lhs: Element, _ rhs: Self) -> Self {
    return rhs + lhs
  }

  static func += (_ lhs: inout Self, _ rhs: Self) {
    lhs = lhs + rhs
  }

  static func += (_ lhs: inout Self, _ rhs: Element) {
    lhs = lhs + rhs
  }

  // -
  static prefix func - (_ z: Self) -> Self {
    return Self(-z.real, -z.imag)
  }

  static func - (_ lhs: Self, _ rhs: Self) -> Self {
    return Self(lhs.real - rhs.real, lhs.imag - rhs.imag)
  }

  static func - (_ lhs: Self, _ rhs: Element) -> Self {
    return Self(lhs.real - rhs, lhs.imag)
  }

  static func - (_ lhs: Element, _ rhs: Self) -> Self {
    return -rhs + lhs
  }

  static func -= (_ lhs: inout Self, _ rhs: Self) {
    lhs = lhs - rhs
  }

  static func -= (_ lhs: inout Self, _ rhs: Element) {
    lhs = lhs - rhs
  }

  // *
  static func * (_ lhs: Self, _ rhs: Self) -> Self {
    return Self(
      lhs.real * rhs.real - lhs.imag * rhs.imag,
      lhs.real * rhs.imag + lhs.imag * rhs.real
    )
  }

  static func * (_ lhs: Self, _ rhs: Element) -> Self {
    return Self(lhs.real * rhs, lhs.imag * rhs)
  }

  static func * (_ lhs: Element, _ rhs: Self) -> Self {
    return rhs * lhs
  }

  static func *= (_ lhs: inout Self, _ rhs: Self) {
    lhs = lhs * rhs
  }

  static func *= (_ lhs: inout Self, _ rhs: Element) {
    lhs = lhs * rhs
  }

  var norm: Element {
    return self.real * self.real + self.imag * self.imag
  }

  /// conjugate
  var conj: Self {
    return Self(real, -imag)
  }
}

typealias ComplexFloatElement = FloatingPoint & FloatingPointMath

protocol ComplexFloat: ComplexNumeric & CustomStringConvertible where Element: ComplexFloatElement { }

extension ComplexFloat {

  /// construct by polar coodinates
  init(abs: Element, arg: Element) {
    self.init(abs * Element.cos(arg), abs * Element.sin(arg))
  }

  ///
  init(_ r: Double) {
    self.init(Element(r), 0)
  }

  ///
  var asDouble: Double {
    return self.real.asDouble
  }

  /// absolute value
  var abs: Element {
    get {
      return imag.isZero ? Swift.abs(real) : Element.hypot(real, imag)
    }
    set {
      self = Self(abs: newValue, arg: self.arg)
    }
  }

  /// magnitude = abs
  var magnitude: Element {
    return self.abs
  }

  /// argument
  var arg: Element {
    get { return Element.atan2(imag, real) }
    set {
      self = Self(abs: self.abs, arg: newValue)
    }
  }

  /// projection
  var proj: Self {
    if real.isFinite && imag.isFinite {
      return self
    } else {
      return Self(.infinity, imag.sign == .minus ? -Element(0): +Element(0))
    }
  }

  /// description -- conforms to CustomStringConvertible
  var description: String {
    let sig = imag.sign == .minus ? "-" : "+"
    return "(\(real)\(sig)\(imag.magnitude).i)"
  }

  /// /
  static func / (_ lhs: Self, _ rhs: Element) -> Self {
    return Self(lhs.real / rhs, lhs.imag / rhs)
  }

  static func / (_ lhs: Self, _ rhs: Self) -> Self {
    return rhs.imag.isZero ? lhs / rhs.real : lhs * rhs.conj / rhs.norm
  }

  static func / (_ lhs: Element, _ rhs: Self) -> Self {
    return Self(lhs, 0) / rhs
  }

  static func /= (_ lhs: inout Self, _ rhs: Self) {
    lhs = lhs / rhs
  }

  static func /= (_ lhs: inout Self, _ rhs: Element) {
    lhs = lhs / rhs
  }

  /// nan
  static var nan: Self { return Self(real: Element.nan, imag: Element.nan)}

  /// check if either real or imag is nan
  var isNaN: Bool { return real.isNaN || imag.isNaN }

  /// infinity + infinity.i
  static var infinity: Self { return Self(real: Element.infinity, imag: Element.infinity)}

  /// check if either real or imag is infinite
  var isInfinite: Bool { return real.isInfinite || imag.isInfinite }

  /// 0.0 + 0.0.i, aka "origin"
  static var zero: Self { return Self(0, 0) }

  /// check if both real and imag are zeros
  var isZero: Bool { return real.isZero && imag.isZero }

  var isReal: Bool {
    return (imag - 0) < Element.epsilon
  }

}

// CMath
extension ComplexFloat {

  /// square root of z in Complex
  static func sqrt(_ z: Self) -> Self {
    let a = z.abs
    let r = Element.sqrt((a + z.real)/2)
    let i = Element.sqrt((a - z.real)/2)
    return Self(r, z.imag.sign == .minus ? -i : i)
  }

  static func sqrt(_ x: Element) -> Self { return sqrt(Self(x)) }

  var sqrt: Self { return Self.sqrt(self) }

  /// e ** z in Complex
  static func exp(_ z: Self) -> Self {
    let r = Element.exp(z.real)
    let a = z.imag
    return Self(r * Element.cos(a), r * Element.sin(a))
  }

  static func exp(_ x: Element) -> Self { return Self(Element.exp(x)) }

  var exp: Self { return Self.exp(self) }

  /// e ** z - 1.0 in Complex
  static func expm1(_ z: Self) -> Self {
    // cf. https://lists.gnu.org/archive/html/octave-maintainers/2008-03/msg00174.html
    return -exp(z/2) * 2 * sin(z.i/2).i
  }

  static func expm1(_ x: Element) -> Self { return Self(Element.expm1(x)) }

  var expm1: Self { return Self.expm1(self) }

  /// natural log of z in Complex
  static func log(_ z: Self) -> Self {
    return Self(Element.log(z.abs), z.arg)
  }

  static func log(_ x: Element) -> Self { return log(Self(x)) }

  var log: Self { return Self.log(self) }

  /// natural log of (z + 1) in Complex
  static func log1p(_ z: Self) -> Self {
    return 2*atanh(z/(z+2))
  }

  static func log1p(_ x: Element) -> Self { return Self(Element.log1p(x)) }

  var log1p: Self { return Self.log1p(self) }

  /// base 2 log of z in Complex
  static func log2(_ z: Self) -> Self {
    return log(z) / Element.log(2)
  }

  static func log2(_ x: Element) -> Self { return log2(Self(x)) }

  var log2: Self { return Self.log2(self) }

  /// base 10 log of z in Complex
  static func log10(_ z: Self) -> Self {
    return log(z) / Element.log(10)
  }

  static func log10(_ x: Element) -> Self { return log10(Self(x)) }

  var log10: Self { return Self.log10(self) }

  /// lhs ** rhs in Complex
  static func pow(_ lhs: Self, _ rhs: Self) -> Self {
    return exp(log(lhs) * rhs)
  }
  static func pow(_ lhs: Self, _ rhs: Element) -> Self { return pow(lhs, Self(rhs)) }
  static func pow(_ lhs: Element, _ rhs: Self) -> Self { return pow(Self(lhs), rhs) }
  static func pow(_ lhs: Element, _ rhs: Element) -> Self { return Self(Element.pow(lhs, rhs)) }

  func pow(_ z: Element) -> Self { return Self.pow(self, z) }
  func pow(_ z: Self) -> Self { return Self.pow(self, z) }

  /// cosine of z in Complex
  static func cos(_ z: Self) -> Self {
    return Self(
      +Element.cos(z.real) * Element.cosh(z.imag),
      -Element.sin(z.real) * Element.sinh(z.imag)
    )
  }
  static func cos(_ x: Element) -> Self { return cos(Self(x)) }

  var cos: Self { return Self.cos(self) }

  /// sine of z in Complex
  static func sin(_ z: Self) -> Self {
    return Self(
      +Element.sin(z.real) * Element.cosh(z.imag),
      +Element.cos(z.real) * Element.sinh(z.imag)
    )
  }
  static func sin(_ x: Element) -> Self { return sin(Self(x)) }

  var sin: Self { return Self.sin(self) }

  /// tangent of z in Complex
  static func tan(_ z: Self) -> Self {
    return sin(z) / cos(z)
  }
  static func tan(_ x: Element) -> Self { return tan(Self(x)) }

  var tan: Self { return Self.tan(self) }

  /// arc cosine of z in Complex
  static func acos(_ z: Self) -> Self {
    return log(z - sqrt(1 - z*z).i).i
  }
  static func acos(_ x: Element) -> Self { return acos(Self(x)) }

  var acos: Self { return Self.acos(self) }

  /// arc sine of z in Complex
  static func asin(_ z: Self) -> Self {
    return -log(z.i + sqrt(1 - z*z)).i
  }
  static func asin(_ x: Element) -> Self { return asin(Self(x)) }

  var asin: Self { return Self.asin(self) }

  /// arc tangent of z in Complex
  static func atan(_ z: Self) -> Self {
    let lp = log(1 - z.i)
    let lm = log(1 + z.i)
    return (lp - lm).i / 2
  }
  static func atan(_ x: Element) -> Self { return atan(Self(x)) }

  var atan: Self { return Self.atan(self) }

  /// hyperbolic cosine of z in Complex
  static func cosh(_ z: Self) -> Self {
    // return (exp(z) + exp(-z)) / T(2)
    return cos(z.i)
  }
  static func cosh(_ x: Element) -> Self { return cosh(Self(x)) }

  var cosh: Self { return Self.cosh(self) }

  /// hyperbolic sine of z in Complex
  static func sinh(_ z: Self) -> Self {
    // return (exp(z) - exp(-z)) / T(2)
    return -sin(z.i).i
  }
  static func sinh(_ x: Element) -> Self { return sinh(Self(x)) }

  var sinh: Self { return Self.sinh(self) }

  /// hyperbolic tangent of z in Complex
  static func tanh(_ z: Self) -> Self {
    // let ez = exp(z), e_z = exp(-z)
    // return (ez - e_z) / (ez + e_z)
    return sinh(z) / cosh(z)
  }
  static func tanh(_ x: Element) -> Self { return tanh(Self(x)) }

  var tanh: Self { return Self.tanh(self) }

  /// inverse hyperbolic cosine of z in Complex
  static func acosh(_ z: Self) -> Self {
    return log(z + sqrt(z+1)*sqrt(z-1))
  }
  static func acosh(_ x: Element) -> Self { return acosh(Self(x)) }

  var acosh: Self { return Self.acosh(self) }

  /// inverse hyperbolic cosine of z in Complex
  static func asinh(_ z: Self) -> Self {
    return log(z + sqrt(z*z+1))
  }
  static func asinh(_ x: Element) -> Self { return asinh(Self(x)) }

  var asinh: Self { return Self.asinh(self) }

  /// inverse hyperbolic tangent of z in Complex
  static func atanh(_ z: Self) -> Self {
    return (log(1 + z) - log(1 - z)) / 2
  }
  static func atanh(_ x: Element) -> Self { return atanh(Self(x)) }

  var atanh: Self { return Self.atanh(self) }

  /// hypotenuse. defined as √(lhs**2 + rhs**2) though its need for Complex is moot.
  static func hypot(_ lhs: Self, _ rhs: Self) -> Self { return sqrt(lhs*lhs + rhs*rhs) }
  static func hypot(_ lhs: Self, _ rhs: Element) -> Self { return hypot(lhs, Self(rhs)) }
  static func hypot(_ lhs: Element, _ rhs: Self) -> Self { return hypot(Self(lhs), rhs) }
  static func hypot(_ lhs: Element, _ rhs: Element) -> Self { return Self(Element.hypot(lhs, rhs)) }

  func hypot(_ z: Element) -> Self { return Self.hypot(self, z) }
  func hypot(_ z: Self) -> Self { return Self.hypot(self, z) }

  /// atan2 = atan(lhs/rhs)
  static func atan2(_ lhs: Self, _ rhs: Self) -> Self { return atan(lhs/rhs) }
  static func atan2(_ lhs: Self, _ rhs: Element) -> Self { return atan2(lhs, Self(rhs, 0)) }
  static func atan2(_ lhs: Element, _ rhs: Self) -> Self { return atan2(Self(lhs, 0), rhs) }
  static func atan2(_ lhs: Element, _ rhs: Element) -> Self { return Self(Element.atan2(lhs, rhs)) }

  func atan2(_ z: Element) -> Self { return Self.atan2(self, z) }
  func atan2(_ z: Self) -> Self { return Self.atan2(self, z) }
}

struct Complex<R: ComplexFloatElement>: ComplexFloat {

  typealias NumericType = R

  var (real, imag): (R, R)

  init(_ r: R) {
    real = r
    imag = 0
  }

  init(real r: R, imag i: R) {
    (real, imag) = (r, i)
  }
}

extension Complex: Codable where Element: Codable {

  enum CodingKeys: String, CodingKey {
    typealias RawValue = String
    case real, imag
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.real = try values.decode(Element.self, forKey: .real)
    self.imag = try values.decode(Element.self, forKey: .imag)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.real, forKey: .real)
    try container.encode(self.imag, forKey: .imag)
  }

}

extension FloatingPoint where Self: ComplexFloatElement {

  var i: Complex<Self> {
    return Complex(0, self)
  }

}
