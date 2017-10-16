import Foundation

public extension Sequence {

  func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
    let result = Dictionary(grouping: self) { key($0) }
    return result
  }
}
