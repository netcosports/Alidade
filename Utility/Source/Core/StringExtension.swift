//
//  StringExtension.swift
//  TourDeFrance
//
//  Created by Dmitry Duleba on 5/1/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation
import UIKit

private let stringSizeCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
  let cache = NSCache<AnyObject, AnyObject>()
  let selector = #selector(NSCache<AnyObject, AnyObject>.removeAllObjects)
  let name = NSNotification.Name.UIApplicationDidReceiveMemoryWarning
  NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
  return cache
}()

private let htmlToPlainStringCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
  let cache = NSCache<AnyObject, AnyObject>()
  let selector = #selector(NSCache<AnyObject, AnyObject>.removeAllObjects)
  let name = NSNotification.Name.UIApplicationDidReceiveMemoryWarning
  NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
  return cache
}()

// MARK: - String

public extension String {

  var trimmed: String { return trimmingCharacters(in: .whitespacesAndNewlines) }
  var length: Int { return characters.count }

  var sentenceCapitalized: String {
    guard length > 0 else { return self }
    let range = startIndex..<index(startIndex, offsetBy: 1)
    let firstLetter = String(self[startIndex]).capitalized
    let result = replacingCharacters(in: range, with: firstLetter)
    return result
  }

  subscript (idx: Int) -> String {
    return String(self[idx] as Character)
  }

  subscript (safe idx: Int) -> String? {
    guard !self.isEmpty, let index = characters.index(startIndex, offsetBy: idx, limitedBy: endIndex) else {
      return nil
    }
    return String(self[index])
  }

  subscript (idx: Int) -> Character {
    return self[characters.index(startIndex, offsetBy: idx)]
  }

  subscript (range: CountableClosedRange<Int>) -> String {
    let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
    let endIndex = index(startIndex, offsetBy: range.upperBound - range.lowerBound)
    return String(self[startIndex...endIndex])
  }

  var attributedTextFromHTML: NSAttributedString? {
    guard let data = data(using: String.Encoding.utf8) else { return nil }

    let encoding = NSNumber(value: String.Encoding.utf8.rawValue)
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: encoding]
    return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
  }

  var plainTextFromHTML: String? {
    let key = hashValue
    if let cachedValue = htmlToPlainStringCache.object(forKey: key as AnyObject) as? String {
      return cachedValue
    }
    if let value = attributedTextFromHTML?.string {
      htmlToPlainStringCache.setObject(value as AnyObject, forKey: key as AnyObject)
      return value
    }
    return nil
  }

  // MARK: Size rendering

  public func fixedWidthSize(_ fixedWidth: CGFloat, with font: UIFont) -> CGSize {
    let string = NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font])
    let result = string.fixedWidthSize(fixedWidth)
    return result
  }

  public func fixedHeightSize(_ fixedHeight: CGFloat, with font: UIFont) -> CGSize {
    let string = NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font])
    let result = string.fixedHeightSize(fixedHeight)
    return result
  }

  public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect,
                                        options: [.usesFontLeading, .usesLineFragmentOrigin],
                                        attributes: [NSAttributedStringKey.font: font],
                                        context: nil)

    return boundingBox.height
  }
}

public extension String {

  func base64String() -> String {
    return Data(self.utf8).base64EncodedString()
  }
}

// MARK: - NSAttributedString

public extension NSAttributedString {

  // MARK: Size rendering

  func fixedWidthSize(_ fixedWidth: CGFloat) -> CGSize {
    let size = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
    let key = size.width.hashValue ^ size.height.hashValue ^ hashValue
    if let cachedValue = stringSizeCache.object(forKey: key as AnyObject) as? NSValue {
      return cachedValue.cgSizeValue
    }

    let result = framesetterLayoutSize(with: size)
    stringSizeCache.setObject(NSValue(cgSize: result), forKey: key as AnyObject)
    return result
  }

  func fixedHeightSize(_ fixedHeight: CGFloat) -> CGSize {
    let size = CGSize(width: .greatestFiniteMagnitude, height: fixedHeight)
    let key = size.width.hashValue ^ size.height.hashValue ^ hashValue
    if let cachedValue = stringSizeCache.object(forKey: key as AnyObject) as? NSValue {
      return cachedValue.cgSizeValue
    }

    let result = framesetterLayoutSize(with: size)
    stringSizeCache.setObject(NSValue(cgSize: result), forKey: key as AnyObject)
    return result
  }

  private func framesetterLayoutSize(with fitSize: CGSize) -> CGSize {
    guard length > 0 else { return .zero }

    let attrString = self as CFAttributedString
    let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attrString)
    var fitRange = CFRange()
    let totalRange = CFRangeMake(0, length)
    let frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, totalRange, nil, fitSize, &fitRange)
    return frameSize
  }

  private func layoutSize(with bounds: CGSize) -> CGSize {
    let textStorage = NSTextStorage(attributedString: self)
    let textContainer = NSTextContainer(size: bounds)
    textContainer.lineFragmentPadding = 0.0
    let layoutManager = NSLayoutManager()

    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)

    _ = layoutManager.glyphRange(for: textContainer)
    return layoutManager.usedRect(for: textContainer).integral.size
}
}
