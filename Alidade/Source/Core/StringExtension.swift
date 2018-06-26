import Foundation

// MARK: - String

public extension String {

  var trimmed: String { return trimmingCharacters(in: .whitespacesAndNewlines) }
  var length: Int { return count }

  var sentenceCapitalized: String {
    guard length > 0 else { return self }

    let letter = self[0].uppercased()
    let range = startIndex..<index(startIndex, offsetBy: 1)
    let result = replacingCharacters(in: range, with: letter)
    return result
  }

  subscript (idx: Int) -> String {
    let index = self.index(startIndex, offsetBy: idx)
    return String(self[index])
  }

  subscript (safe idx: Int) -> String? {
    let index = self.index(startIndex, offsetBy: idx)
    guard !isEmpty, (startIndex...endIndex).contains(index) else {
      return nil
    }
    return String(self[index])
  }

  subscript (range: Range<Int>) -> String {
    let from = index(startIndex, offsetBy: range.lowerBound)
    let to = index(startIndex, offsetBy: range.upperBound)
    return String(self[from..<to])
  }

  subscript (range: ClosedRange<Int>) -> String {
    let from = index(startIndex, offsetBy: range.lowerBound)
    let to = index(startIndex, offsetBy: range.upperBound)
    return String(self[from...to])
  }
}
