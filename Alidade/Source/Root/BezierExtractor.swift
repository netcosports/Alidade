//
//  Created by Dmitry Duleba on 4/8/19.
//

import UIKit

// swiftlint:disable identifier_name

public struct BezierExtractor {

  public enum Bezier {
    case close(p0: CGPoint)
    case move(p0: CGPoint)
    case line(p0: CGPoint, p1: CGPoint)
    case quadratic(p0: CGPoint, c0: CGPoint, p1: CGPoint)
    case cubic(p0: CGPoint, c0: CGPoint, c1: CGPoint, p1: CGPoint)

    public var points: [CGPoint] {
      switch self {
      case .close(let p0): return [p0]
      case .move(let p0): return [p0]
      case .line(let p0, let p1): return [p0, p1]
      case .quadratic(let p0, _, let p1): return [p0, p1]
      case .cubic(let p0, _, _, let p1): return [p0, p1]
      }
    }

    public var controlPoints: [CGPoint] {
      switch self {
      case .close: return []
      case .move: return []
      case .line: return []
      case .quadratic(_, let c0, _): return [c0]
      case .cubic(_, let c0, let c1, _): return [c0, c1]
      }
    }

  }

  private class Container {

    var array: [Bezier] = []
    var currentPoint: CGPoint = .zero
    var currentSubpathStartPoint: CGPoint = .zero

  }

  private let container: Container
  public var bezier: [Bezier] { return container.array }

  public init(path: UIBezierPath) {
    let cgPath = path.cgPath
    let container = Container()
    let unsafeBody = unsafeBitCast(container, to: UnsafeMutableRawPointer.self)
    cgPath.apply(info: unsafeBody, function: { body, element in
      guard let body = body else { return }

      let container = unsafeBitCast(body, to: Container.self)
      switch element.pointee.type {
      case .closeSubpath:
        let p0 = container.currentSubpathStartPoint
        container.array.append(.close(p0: p0))
      case .moveToPoint:
        let p0 = element.pointee.points[0]
        container.array.append(.move(p0: p0))
        container.currentPoint = p0
        container.currentSubpathStartPoint = p0
      case .addLineToPoint:
        let p0 = container.currentPoint
        let p1 = element.pointee.points[0]
        container.array.append(.line(p0: p0, p1: p1))
        container.currentPoint = p1
      case .addQuadCurveToPoint:
        let p0 = container.currentPoint
        let c0 = element.pointee.points[0]
        let p1 = element.pointee.points[1]
        container.array.append(.quadratic(p0: p0, c0: c0, p1: p1))
        container.currentPoint = p1
      case .addCurveToPoint:
        let p0 = container.currentPoint
        let c0 = element.pointee.points[0]
        let c1 = element.pointee.points[1]
        let p1 = element.pointee.points[2]
        container.array.append(.cubic(p0: p0, c0: c0, c1: c1, p1: p1))
        container.currentPoint = p1
      @unknown default: break
      }
    })
    self.container = container
  }

}
