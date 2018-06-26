import Foundation

// MARK: - Sequence

public extension Sequence {

  func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
    let result = Dictionary(grouping: self) { key($0) }
    return result
  }
}

// MARK: - Array

public extension Array {

  subscript(safe idx: Int) -> Element? {
    return (0..<count).contains(idx) ? self[idx] : nil
  }
}

public extension Array where Element: Equatable {

  public mutating func remove(_ element: Element) {
    if let index = index(of: element) {
      remove(at: index)
    }
  }
}
