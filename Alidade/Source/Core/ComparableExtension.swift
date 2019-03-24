import Foundation
import struct UIKit.CGFloat

public extension Comparable {

  func clamp(_ min: Self, _ max: Self) -> Self {
    let realMin = Swift.min(min, max)
    let realMax = Swift.max(min, max)
    let result = Swift.max(Swift.min(self, realMax), realMin)
    return result
  }

}

public extension Comparable where Self == CGFloat {

  func clamp(_ min: CGFloat = 0.0, _ max: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
    return CGFloat.minimum(CGFloat.maximum(self, min), max)
  }

}

public extension Comparable where Self == Int {

  func clamp(_ min: Int = 0, _ max: Int = .max) -> Int {
    let realMin = Swift.min(min, max)
    let realMax = Swift.max(min, max)
    let result = Swift.max(Swift.min(self, realMax), realMin)
    return result
  }

}
