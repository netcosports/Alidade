//
//  ComparableExtension.swift
//
//  Created by Dmitry Duleba on 4/27/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension Comparable {

  func clamp(_ min: Self, _ max: Self) -> Self {
    let realMin = Swift.min(min, max)
    let realMax = Swift.max(min, max)
    let result = Swift.max(Swift.min(self, realMax), realMin)
    return result
  }
}
