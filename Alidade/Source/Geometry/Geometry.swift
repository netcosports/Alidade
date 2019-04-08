//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

// swiftlint:disable identifier_name
public enum Geometry {

  public struct Ray {
    public let start: CGPoint
    public let direction: CGPoint

    public init(start: CGPoint, direction: CGPoint) {
      self.start = start
      self.direction = direction.normalized
    }

    public func intersection(with line: Line) -> CGPoint? {
      let rLine = Line(self)
      guard let intersection = rLine.intersection(with: line) else {
        return nil
      }
      guard (intersection - start).normalized.isFuzzyEqual(to: direction) else {
        return nil
      }
      return intersection
    }
  }

  public struct Line {
    public let p0: CGPoint
    public let p1: CGPoint

    public init(p0: CGPoint, p1: CGPoint) {
      self.p0 = p0
      self.p1 = p1
    }

    public init(_ ray: Ray) {
      p0 = ray.start
      p1 = p0 + ray.direction
    }

    public func intersection(with line: Line) -> CGPoint? {
      let p2 = line.p0
      let p3 = line.p1
      let d = (p1.x - p0.x) * (p3.y - p2.y) - (p1.y - p0.y) * (p3.x - p2.x)
      guard d != 0 else { // parallel lines
        return nil
      }

      let u = ((p2.x - p0.x) * (p3.y - p2.y) - (p2.y - p0.y) * (p3.x - p2.x)) / d
      let intersection = CGPoint(x: p0.x + u * (p1.x - p0.x),
                                 y: p0.y + u * (p1.y - p0.y))
      return intersection
    }
  }

  public struct Segment {
    public let p0: CGPoint
    public let p1: CGPoint

    public init(p0: CGPoint, p1: CGPoint) {
      self.p0 = p0
      self.p1 = p1
    }

    public var length: CGFloat {
      return sqrt((p1.x - p0.x) * (p1.x - p0.x) + (p1.y - p0.y) * (p1.y - p0.y))
    }

    public func intersection(with segment: Segment) -> CGPoint? {
      let p2 = segment.p0
      let p3 = segment.p1
      let d = (p1.x - p0.x) * (p3.y - p2.y) - (p1.y - p0.y) * (p3.x - p2.x)
      guard d != 0 else { // parallel lines
        return nil
      }

      let u = ((p2.x - p0.x) * (p3.y - p2.y) - (p2.y - p0.y) * (p3.x - p2.x)) / d
      let v = ((p2.x - p0.x) * (p1.y - p0.y) - (p2.y - p0.y) * (p1.x - p0.x)) / d
      guard !(u < 0.0 || u > 1.0) else { // intersection point not between p1 and p2
        return nil
      }
      guard !(v < 0.0 || v > 1.0) else { // intersection point not between p3 and p4
        return nil
      }
      let intersection = CGPoint(x: p0.x + u * (p1.x - p0.x),
                                 y: p0.y + u * (p1.y - p0.y))
      return intersection
    }
  }
}
