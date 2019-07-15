//
//  Created by Dmitry Duleba on 3/15/19.
//

import UIKit

// swiftlint:disable identifier_name

extension UIBezierPath: GeometrySupportable { }

fileprivate extension Geometry {

  enum Const {
    static let markerRadius: CGFloat = 5

  }
}

public extension GeometryExtension where Base: UIBezierPath {

  func add(_ line: Geometry.Line, from: CGFloat, to: CGFloat) {
    let from = line.point(at: from)
    let to = line.point(at: to)
    if !base.currentPoint.x.isFuzzyEqual(to: from.x) || !base.currentPoint.y.isFuzzyEqual(to: from.y) {
      base.move(to: from)
    }
    base.addLine(to: to)
  }

  func add(_ circle: Geometry.Circle) {
    let c = circle.center
    let r = circle.radius
    base.move(to: CGPoint(x: c.x + r, y: c.y))
    base.addArc(withCenter: c, radius: r, startAngle: 0, endAngle: .pi * 2.0, clockwise: true)
  }

  func add(_ intersection: Geometry.Operation.Intersection, markerRadius: CGFloat? = nil) {
    let markerRadius = markerRadius ?? Geometry.Const.markerRadius
    if case .points(let points) = intersection {
      points.forEach {
        add($0, markerRadius: markerRadius)
      }
    }
  }

  func add(_ point: CGPoint, markerRadius: CGFloat? = nil) {
    let markerRadius = markerRadius ?? Geometry.Const.markerRadius
    base.move(to: CGPoint(x: point.x + markerRadius, y: point.y))
    base.addArc(withCenter: point, radius: markerRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
  }

  func add(_ arc: Geometry.Arc) {
    base.addArc(withCenter: arc.center, radius: arc.radius,
                startAngle: arc.start, endAngle: arc.end, clockwise: arc.clockwise)
  }

}
