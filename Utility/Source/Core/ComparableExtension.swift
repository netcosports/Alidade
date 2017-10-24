import Foundation

public extension Comparable {

  func clamp(_ min: Self, _ max: Self) -> Self {
    let realMin = Swift.min(min, max)
    let realMax = Swift.max(min, max)
    let result = Swift.max(Swift.min(self, realMax), realMin)
    return result
  }
}
