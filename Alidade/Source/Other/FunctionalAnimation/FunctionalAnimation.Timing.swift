//
//  Created by Dmitry Duleba on 3/26/19.
//

import UIKit

// swiftlint:disable identifier_name

public extension FunctionalAnimation {

  struct Timing: Equatable {

    private let bezier: BezierCurve

    init(_ points: [CGPoint]) {
      bezier = BezierCurve(points: points)
    }

    init(name: CAMediaTimingFunctionName) {
      var points: [CGPoint] = []
      var buffer: [Float] = [0, 0]
      let timingFunction = CAMediaTimingFunction(name: name)
      for i in 0...3 {
        var point = CGPoint()
        timingFunction.getControlPoint(at: i, values: &buffer)
        point.x = CGFloat(buffer[0])
        point.y = CGFloat(buffer[1])
        points.append(point)
      }
      bezier = BezierCurve(points: points)
    }

    func coords(for t: CGFloat) -> CGPoint {
      return bezier.f_t(t.clamp(0.0, 1.0))
    }

    func value(for x: CGFloat) -> CGFloat {
      return bezier.f_x(x.clamp(0, 1))
    }

  }
}

private extension CGFloat {

  func pow(_ n: Int) -> CGFloat {
    return CGFloat(Foundation.pow(Double(self), Double(n)))
  }

}

// MARK: - FunctionalAnimation.Timing.BezierCurve

fileprivate extension FunctionalAnimation.Timing {

  struct BezierCurve: Equatable {

    let points: [CGPoint]
    private let pascalRow: [Int]

    init(points: [CGPoint]) {
      self.points = points
      self.pascalRow = BezierCurve.pascal(at: points.count - 1)
    }

    func f_t(_ t: CGFloat) -> CGPoint {
      if points.count == 0 { return .zero }
      if points.count == 1 { return points[0] }

      var result = CGPoint.zero
      let n = points.count - 1
      let pascalRow = self.pascalRow
      points.enumerated().forEach { i, point in
        let p = CGFloat(pascalRow[i])
        let multiplier = p * (1 - t).pow(n - i) * t.pow(i)
        result.x += point.x * multiplier
        result.y += point.y * multiplier
      }
      return result
    }

    func f_x(_ x: CGFloat) -> CGFloat {
      guard points.count > 0 else { return 0 }

      var t_x_coeffiecients = polynomialForm(points: points.map { $0.x }).coefficients
      t_x_coeffiecients.last.with { last in
        let last_x = last - x
        t_x_coeffiecients = t_x_coeffiecients.dropLast() + [last_x]
      }
      let t_x = Polynomial(t_x_coeffiecients)
      let roots = t_x.roots()
      guard let t = roots
        .filter({ $0.isReal })
        .map({ $0.real })
        .first(where: { (CGFloat(0)...1).contains($0) }) else { return 0.0 }

      let t_y = polynomialForm(points: points.map { $0.y })
      let y = t_y.value(for: t)
      return y
    }

  }
}

// MARK: - BezierCurve.Private

private extension FunctionalAnimation.Timing.BezierCurve {

  // MARK: - Help

  static func pascal(at n: Int) -> [Int] {
    guard n > 0 else { return [] }

    var line = [1]
    for k in 0..<n {
      line.append(line[k] * (n - k) / (k + 1))
    }
    return line
  }

  func polynomialForm(points: [CGFloat]) -> Polynomial<CGFloat> {
    let n = points.count - 1
    let coefficients: [CGFloat] = (0...n).reversed()
      .map { j in
        let product = self.product(j, n)
        var sum: CGFloat = 0
        for i in 0...j {
          let minusOneSign = self.minusOneSign(i, j)
          let i_fact = CGFloat(i.factorial)
          let j_i_fact = CGFloat((j - i).factorial)
          sum += minusOneSign * points[i] / i_fact / j_i_fact
        }
        let coefficient = product * sum
        return coefficient
    }
    return Polynomial<CGFloat>(coefficients)
  }

  func product(_ j: Int, _ n: Int) -> CGFloat {
    var result: Int = 1
    for m in 0...((j - 1).clamp(0)) {
      result *= (n - m)
    }
    return CGFloat(result)
  }

  func minusOneSign(_ i: Int, _ j: Int) -> CGFloat {
    if (i + j) % 2 == 0 {
      return 1.0
    }
    return -1.0
  }

}

// MARK: - Polynomial.Private

private extension Polynomial where Scalar == CGFloat {

  func value(for x: CGFloat) -> CGFloat {
    let degree = self.degree
    var result: CGFloat = 0
    for i in 0...degree {
      let c = coefficients[i]
      let power = degree - i
      result += x.pow(power) * c
    }
    return result
  }

}

private extension Int {

  private static var factorialCache = [Int: Int]()

  var factorial: Int { return Int.factorial(for: self) }

  private static func factorial(for x: Int) -> Int {
    guard x > 1 else { return 1 }

    if let cached = Int.factorialCache[x] {
      return cached
    }
    let result = x * factorial(for: x - 1)
    Int.factorialCache[x] = result
    return result
  }

}
