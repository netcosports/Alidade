//
//  Created by Dmitry Duleba on 3/15/19.
//

import UIKit

// swiftlint:disable identifier_name

// MARK: - Line

public extension Geometry {

  struct Line {

    let a: CGFloat
    let b: CGFloat
    let c: CGFloat

    var alt: (k: CGFloat, b: CGFloat) { return (-b / a, -c / a) }

    // MARK: - Init

    init(a: CGFloat, b: CGFloat, c: CGFloat) {
      self.a = a
      self.b = b
      self.c = c
    }

    init(k: CGFloat, b: CGFloat) {
      a = 1
      self.b = -k
      c = -b
    }

    init(p0: CGPoint, p1: CGPoint) {
      let k = (p1.y - p0.y) / (p1.x - p0.x)
      let b = (p0.x * p1.y + p0.y * p1.x) / (p0.x - p1.x)
      self.init(k: k, b: b)
    }

    init(y: CGFloat) {
      self.init(a: 0, b: 1, c: -y)
    }

    // MARK: - Public

    func f(_ x: CGFloat) -> CGFloat {
      return -a/b * x - c/b
    }

    func point(at x: CGFloat) -> CGPoint {
      return CGPoint(x: x, y: f(x))
    }

    @inline(__always)
    func move(x: CGFloat, y: CGFloat) -> Line {
      return Line(a: a, b: b, c: c - a * x - b * y)
    }

  }
}

// MARK: - Circle

public extension Geometry {

  struct Circle {

    let center: CGPoint
    let radius: CGFloat

    @inline(__always)
    func move(x: CGFloat, y: CGFloat) -> Circle {
      return Circle(center: CGPoint(x: center.x + x, y: center.y + y), radius: radius)
    }

    func angle(to point: CGPoint) -> CGFloat {
      let x = point.x - center.x
      let y = point.y - center.y
      return atan2(y, x)
    }

    func arc(from fromPoint: CGPoint, to toPoint: CGPoint, clockwise: Bool = true) -> Arc {
      let from = angle(to: fromPoint)
      let to = angle(to: toPoint)
      return Arc(circle: self, start: from, end: to, clockwise: clockwise)
    }

  }
}

// MARK: - Arc

public extension Geometry {

  struct Arc {

    let circle: Circle
    let start: CGFloat
    let end: CGFloat
    let clockwise: Bool

    var center: CGPoint { return circle.center }

    var radius: CGFloat { return circle.radius }

  }
}
