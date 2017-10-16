import Foundation

public extension Array {

  subscript(safe index: Int) -> Element? {
    return index >= 0 && index < self.count ? self[index] : nil
  }
}

public extension Array where Element : Equatable {

  public mutating func remove(_ element: Element) {
    if let index = index(of: element) {
      remove(at: index)
    }
  }
}
