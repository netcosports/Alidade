//
//  CGFloat+Geometry.swift
//
//  Created by Dmitry Duleba on 4/18/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import UIKit

public extension CGFloat {

  public static let epsilon: CGFloat = 1e-10
  public static var random: CGFloat {
    return CGFloat(arc4random_uniform(1000)) / 1000.0
  }
  public static var pixel: CGFloat {
    return 1.0 / UIScreen.main.scale
  }

  public var normalized: CGFloat { return clamp(0.0, 1.0) }

  public func clamp(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
    return CGFloat.minimum(CGFloat.maximum(self, min), max)
  }

  public func cycleClamp(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
    if self >= min && self <= max { return self }
    let range = max - min
    let value = truncatingRemainder(dividingBy: range)
    if value < min { return value + range }
    if value > max { return value - range }
    return value
  }

  public func isFuzzyEqual(to value: CGFloat, epsilon: CGFloat = .epsilon) -> Bool {
    return fabs(self - value) <= epsilon
  }
}
