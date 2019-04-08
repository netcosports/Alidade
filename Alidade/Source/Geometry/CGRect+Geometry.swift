//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

public extension CGRect {

  //swiftlint:disable identifier_name
  func intersection(with ray: Geometry.Ray) -> CGPoint? {
    let p0 = CGPoint(x: minX, y: minY)
    let p1 = CGPoint(x: minX, y: maxY)
    let p2 = CGPoint(x: maxX, y: maxY)
    let p3 = CGPoint(x: maxX, y: minY)

    let l0 = Geometry.Line(p0: p0, p1: p1)
    let l1 = Geometry.Line(p0: p1, p1: p2)
    let l2 = Geometry.Line(p0: p2, p1: p3)
    let l3 = Geometry.Line(p0: p3, p1: p0)

    let intersection = [l0, l1, l2, l3]
      .compactMap { ray.intersection(with: $0) }
      .map { (Geometry.Segment(p0: $0, p1: ray.start).length, $0) }
      .min { $0.0 < $1.0 }
      .map { $1 }
    return intersection
  }
  //swiftlint:enable identifier_name

}
