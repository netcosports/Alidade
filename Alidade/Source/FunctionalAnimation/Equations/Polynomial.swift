//    The MIT License (MIT)
//
//    Copyright (c) 2015 Matteo Battaglio, 2014 Dan Kogai
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
//    Polinomial.swift
//    SwiftMath
//
//    Created by Matteo Battaglio on 08/01/15.
//    Copyright (c) 2015 Matteo Battaglio. All rights reserved.
//

// swiftlint:disable identifier_name

import Foundation

// swiftlint:disable identifier_name

struct Polynomial<Scalar: FloatingPoint & FloatingPointMath> {

  enum Const {
    static var maxIterationsCount: Int { return 1000 }
  }

  typealias Value = Complex<Scalar>

  let coefficients: [Scalar]

  /**
   Creates a new instance of `Polynomial` with the given coefficients.

   :param: coefficients The coefficients for the terms of the polinomial,
   ordered from the coefficient for the highest-degree term to the coefficient for the 0 degree term.
   */
  init(_ coefficients: Scalar...) {
    self.init(coefficients)
  }

  /**
   Creates a new instance of `Polynomial` with the given coefficients.

   :param: coefficients The coefficients for the terms of the polinomial,
   ordered from the coefficient for the highest-degree term to the coefficient for the 0 degree term.
   */
  init(_ coefficients: [Scalar]) {
    if coefficients.count == 0 || (coefficients.count == 1 && coefficients[0].isZero) {
      preconditionFailure("the zero polynomial is undefined")
    }
    self.coefficients = coefficients
  }

  /// The grade of the polinomial. It's equal to the number of coefficient minus one.
  var degree: Int {
    return coefficients.count - 1
  }

  /// Finds the roots of the polynomial.
  func roots(shouldUseClosedFormSolution: Bool = true) -> [Value] {
    switch (degree, shouldUseClosedFormSolution) {
    case (1, true): return linear()
    case (2, true): return quadratic()
    case (3, true): return cubic()
    case (4, true): return quartic()
    default: return durandKernerMethod()
    }
  }

}

// MARK: - Private

private extension Polynomial {

  func linear() -> [Value] {
    let a = coefficients[0]
    let b = coefficients[1]

    if a.isZero {
      return []
    }

    let x = -b / a
    return [Value(x)]
  }

  func quadratic() -> [Value] {
    let a = coefficients[0]
    let b = coefficients[1]
    let c = coefficients[2]

    if a.isZero {
      return Polynomial(b, c).roots()
    }

    if c.isZero {
      return [Value.zero] + Polynomial(a, b).roots()
    }

    let discriminant = (b * b) - (Scalar(4.0) * a * c)
    var dSqrt = Value(discriminant).sqrt
    if b.sign == .minus {
      dSqrt = -dSqrt
    }
    let x1 = -(b + dSqrt) / (Scalar(2.0) * a)
    let x2 = -(b - dSqrt) / (Scalar(2.0) * a)

    return [x1, x2]
  }

  // swiftlint:disable:next function_body_length
  func cubic() -> [Value] {
    var a = coefficients[0]
    var b = coefficients[1]
    var c = coefficients[2]
    let d = coefficients[3]

    if a.isZero {
      return Polynomial(b, c, d).roots()
    }
    if d.isZero {
      return [Value.zero] + Polynomial(a, b, c).roots()
    }

    if a != Scalar(1) {
      let divisor = a
      a = b / divisor
      b = c / divisor
      c = d / divisor
    } else {
      a = b
      b = c
      c = d
    }

    let a_2 = a * a
    let a_3 = a_2 * a
    let Q = (a_2 - Scalar(3.0) * b) / Scalar(9.0)
    let ab = a * b
    var R = Scalar(2.0) * a_3
    R -= Scalar(9.0) * ab
    R += Scalar(27.0) * c
    R /= Scalar(54.0)
    let Q_3 = Q * Q * Q
    let R_2 = R * R
    let S = Q_3 - R_2

    let third = Scalar(1.0 / 3.0)
    let a_third = a * third
    let Q_3_pow_0_5 = Value.sqrt(Value(Q_3))
    if S > 0 {
      let phi = third * Value.acos(R / Q_3_pow_0_5)
      let z = Scalar(-2.0) * Value.sqrt(Q)
      let x1 = z * Value.cos(phi) - a_third

      let x2_phi = phi + Scalar(2.0 / 3.0 * .pi)
      let x2 = z * Value.cos(x2_phi) - a_third

      let x3_phi = phi - Scalar(2.0 / 3.0 * .pi)
      let x3 = z * Value.cos(x3_phi) - a_third
      return [x1, x2, x3]
    }

    if S == 0 {
      let R_cubic_root = Value.pow(Value(R), third)
      let x1 = Scalar(-2.0) * R_cubic_root - a_third
      let x2 = R_cubic_root - a_third
      return [x1, x2]
    }

    let sgnR = Scalar(R.sign == .minus ? -1.0 : 1.0)
    if Q > 0 {
      let phi = third * Value.acosh(abs(R) / Q_3_pow_0_5)
      let Q_0_5 = sqrt(Q)
      let ch = Value.cosh(phi)

      let sgnR_Q_0_5_ch = sgnR * Q_0_5 * ch
      let x1 = Scalar(-2.0) * sgnR_Q_0_5_ch - a_third

      let sh = Value.sinh(phi)
      let z = sqrt(3) * Q_0_5 * sh
      let x2 = sgnR_Q_0_5_ch - a_third + z.i
      let x3 = sgnR_Q_0_5_ch - a_third - z.i
      return [x1, x2, x3]
    }

    if Q < 0 {
      let Q_abs = abs(Q)
      let Q_abs_3_0_5 = sqrt(Q_abs * Q_abs * Q_abs)

      let phi = third * Value.asinh(abs(R) / Q_abs_3_0_5)
      let Q_0_5 = sqrt(Q_abs)
      let sh = Value.sinh(phi)

      let sgnR_Q_0_5_sh = sgnR * Q_0_5 * sh
      let x1 = Scalar(-2.0) * sgnR_Q_0_5_sh - a_third

      let ch = Value.cosh(phi)
      let z = sqrt(3) * Q_0_5 * ch
      let x2 = sgnR_Q_0_5_sh - a_third + z.i
      let x3 = sgnR_Q_0_5_sh - a_third - z.i
      return [x1, x2, x3]
    }

    var x1 = Value(c - a_3 / Scalar(27.0))
    x1 = -Value.pow(x1, third) - a_third

    let u = -(a + x1) / Scalar(2.0)
    var v = a - Scalar(3.0) * x1
    v *= a + x1
    v -= Scalar(4.0) * b
    v = Value.sqrt(Value(v.abs)).i / Scalar(2.0)

    let x2 = u + v
    let x3 = u - v
    return [x1, x2, x3]
  }

  // swiftlint:disable:next function_body_length
  func quartic() -> [Value] {
    var a = coefficients[0]
    var b = coefficients[1]
    var c = coefficients[2]
    var d = coefficients[3]
    let e = coefficients[4]

    if a.isZero {
      return Polynomial(b, c, d, e).roots()
    }
    if e.isZero {
      return [Value.zero] + Polynomial(a, b, c, d).roots()
    }
    if b.isZero && d.isZero { // Biquadratic
      let squares = Polynomial(a, c, e).roots()
      return squares.flatMap { square -> [Value] in
        let x = Value.sqrt(square)
        return [x, -x]
      }
    }

    // Lodovico Ferrari's solution
    // Converting to a depressed quartic
    let a1 = b / a
    b = c / a
    c = d / a
    d = e / a
    a = a1

    let a2 = a * a
    let minus3a2 = Scalar(-3.0) * a2
    let ac64 = Scalar(64.0) * a * c
    let a2b16 = Scalar(16.0) * a2 * b
    let aOn4 = a / Scalar(4.0)

    let p = b + minus3a2 / Scalar(8.0)
    let ab4 = Scalar(4.0) * a * b
    let q = (a2 * a - ab4) / Scalar(8.0) + c
    let r1 = minus3a2 * a2 - ac64 + a2b16
    let r = r1 / Scalar(256.0) + d

    // Depressed quartic: u^4 + p*u^2 + q*u + r = 0
    if q.isZero { // Depressed quartic is biquadratic
      let squares = Polynomial(Scalar(1.0), p, r).roots()
      return squares.flatMap { square -> [Value] in
        let x = Value.sqrt(square)
        return [x - aOn4, -x - aOn4]
      }
    }

    let p2 =  p * p
    let q2On8 = q * q / Scalar(8.0)

    let cb = Scalar(2.5) * p
    let cc = Scalar(2.0) * p2 - r
    let cd = Scalar(0.5) * p * (p2 - r) - q2On8
    let yRoots = Polynomial(Scalar(1.0), cb, cc, cd).roots()

    let y = yRoots[yRoots.startIndex]
    let y2 = Scalar(2.0) * y
    let sqrtPPlus2y = Value.sqrt(p + y2)
    precondition(sqrtPPlus2y.isZero == false,
                 "Failed to properly handle the case of the depressed quartic being biquadratic")
    let p3 = Scalar(3.0) * p
    let q2 = Scalar(2.0) * q
    let fraction = q2 / sqrtPPlus2y
    let p3Plus2y = p3 + y2

    let v1_3 = -p3Plus2y - fraction
    let v2_4 = -p3Plus2y + fraction

    let u1 = Scalar(0.5) * (sqrtPPlus2y + Value.sqrt(v1_3))
    let u2 = Scalar(0.5) * (-sqrtPPlus2y + Value.sqrt(v2_4))
    let u3 = Scalar(0.5) * (sqrtPPlus2y - Value.sqrt(v1_3))
    let u4 = Scalar(0.5) * (-sqrtPPlus2y - Value.sqrt(v2_4))
    return [
      u1 - aOn4,
      u2 - aOn4,
      u3 - aOn4,
      u4 - aOn4
    ]
  }

  // swiftlint:disable:next line_length
  /// Implementation of the [Durand-Kerner-Weierstrass method](https://en.wikipedia.org/wiki/Durand%E2%80%93Kerner_method).
  func durandKernerMethod() -> [Value] {
    var coefficients = self.coefficients.map { Value($0, Scalar(0)) }

    let one = Value(Scalar(1), Scalar(0))

    if coefficients[0] != one {
      coefficients = coefficients.map { coefficient in
        coefficient / coefficients[0]
      }
    }

    var a0: [Value] = [one]
    for _ in 1..<coefficients.count-1 {
      if let last = a0.last {
        a0.append(last * Value(Scalar(0.4), Scalar(0.9)))
      }
    }

    var count = 0
    while count < Const.maxIterationsCount {
      var roots: [Value] = []
      for i in 0..<a0.count {
        var result = one
        for j in 0..<a0.count where i != j {
          result = (a0[i] - a0[j]) * result
        }
        roots.append(a0[i] - (eval(coefficients, a0[i]) / result))
      }
      if done(a0, roots) {
        print("Iterations count: \(count)")
        return roots
      }
      a0 = roots
      count += 1
    }

    return a0
  }

  // MARK: - Help

  func eval(_ coefficients: [Value], _ x: Value) -> Value {
    var result = coefficients[0]
    for i in 1..<coefficients.count {
      result = (result * x) + coefficients[i]
    }
    return result
  }

  func done(_ aa: [Value], _ bb: [Value], _ epsilon: Scalar = Scalar.ulpOfOne) -> Bool {
    for (a, b) in zip(aa, bb) {
      let delta = a - b
      if delta.abs > epsilon {
        return false
      }
    }
    return true
  }

}
