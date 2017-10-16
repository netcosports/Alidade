//
//  String+Emoji.swift
//  TourDeFrance
//
//  Created by Dmitry Duleba on 5/11/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation
import CoreText

extension UnicodeScalar {

  var isEmoji: Bool {
    switch value {
    case 0x3030, 0x00AE, 0x00A9: fallthrough  // Special Characters
    case 0x1D000 ... 0x1F77F: fallthrough     // Emoticons
    case 0x2100 ... 0x27BF: fallthrough       // Misc symbols and Dingbats
    case 0xFE00 ... 0xFE0F: fallthrough       // Variation Selectors
    case 0x1F900 ... 0x1F9FF:                 // Supplemental Symbols and Pictographs
    return true

    default: return false
    }
  }

  var isZeroWidthJoiner: Bool {
    return value == 8205
  }
}

public extension String {

  var glyphCount: Int {
    let richText = NSAttributedString(string: self)
    let line = CTLineCreateWithAttributedString(richText)
    return CTLineGetGlyphCount(line)
  }

  var isSingleEmoji: Bool {
    return glyphCount == 1 && containsEmoji
  }

  var containsEmoji: Bool {
    return !unicodeScalars.filter { $0.isEmoji }.isEmpty
  }

  var containsOnlyEmoji: Bool {
    return unicodeScalars.first(where: { !$0.isEmoji && !$0.isZeroWidthJoiner }) == nil
  }

  // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
  // If anyone has suggestions how to improve this, please let me know
  var emojiString: String {
    return emojiScalars.map { String($0) }.reduce("", +)
  }

  var emojis: [String] {
    var scalars: [[UnicodeScalar]] = []
    var currentScalarSet: [UnicodeScalar] = []
    var previousScalar: UnicodeScalar?
    for scalar in emojiScalars {
      if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
        scalars.append(currentScalarSet)
        currentScalarSet = []
      }
      currentScalarSet.append(scalar)
      previousScalar = scalar
    }
    scalars.append(currentScalarSet)
    return scalars.map { $0.map { String($0) } .reduce("", +) }
  }

  fileprivate var emojiScalars: [UnicodeScalar] {
    var chars: [UnicodeScalar] = []
    var previous: UnicodeScalar?
    for cur in unicodeScalars {
      if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
        chars.append(previous)
        chars.append(cur)
      } else if cur.isEmoji {
        chars.append(cur)
      }
      previous = cur
    }
    return chars
  }

  func stringByRemovingEmoji() -> String {
    var unicodeScalarView = String.UnicodeScalarView()
    unicodeScalarView.append(contentsOf: unicodeScalars.filter({ !($0.isEmoji || $0.isZeroWidthJoiner) }))
    let string = String(unicodeScalarView)
    return string
  }
}
