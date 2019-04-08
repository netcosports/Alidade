//
//  Created by Dmitry Duleba on 3/15/19.
//

import UIKit

// swiftlint:disable identifier_name

public extension Geometry {

    enum Operation { }

    fileprivate enum Const {
        static let eps: CGFloat = 0.000_000_1
    }

}

// MARK: - Intersection

public extension Geometry.Operation {

    enum Intersection {
        case none
        case infinty
        case points([CGPoint])
    }

    static func intersection(line: Geometry.Line, circle: Geometry.Circle) -> Intersection {
        let offset = circle.center
        let line = line.move(x: -offset.x, y: -offset.y)
        let a = line.a
        let b = line.b
        let c = line.c
        let r = circle.radius
        let ab_sq_sum = a * a + b * b
        let r_sq = r * r
        let c_sq = c * c
        let x0 = -a * c / ab_sq_sum
        let y0 = -b * c / ab_sq_sum
        if c_sq > r_sq * ab_sq_sum + Geometry.Const.eps {
            return .none
        } else if abs(c_sq - r_sq * ab_sq_sum) < Geometry.Const.eps {
            return .points([.init(x: x0 + offset.x, y: y0 + offset.y)])
        }
        let d = r_sq - c_sq / ab_sq_sum
        let mult = sqrt(d / ab_sq_sum)
        let p0 = CGPoint(x: x0 + b * mult + offset.x, y: y0 - a * mult + offset.y)
        let p1 = CGPoint(x: x0 - b * mult + offset.x, y: y0 + a * mult + offset.y)
        return .points([p0, p1])
    }

    static func intersection(circle_0: Geometry.Circle, circle_1: Geometry.Circle) -> Intersection {
        guard circle_0.center != circle_1.center else {
            if circle_0.radius == circle_1.radius {
                return .infinty
            }
            return .none
        }

        let offset = circle_0.center
        let circle_0 = circle_0.move(x: -offset.x, y: -offset.y)
        let circle_1 = circle_1.move(x: -offset.x, y: -offset.y)

        let r0 = circle_0.radius
        let r1 = circle_1.radius
        let c1 = circle_1.center

        let (x, y) = (c1.x, c1.y)
        let line = Geometry.Line(a: -2 * x,
                        b: -2 * y,
                        c: x * x + y * y + r0 * r0 - r1 * r1)
        let intersection = self.intersection(line: line, circle: circle_0)
        if case .points(let points) = intersection {
            return .points(points.map { CGPoint(x: $0.x + offset.x, y: $0.y + offset.y) })
        }
        return intersection
    }

}
