//
//  String+Rendering.swift
//  Alidade
//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

public enum StringSizeCalculationMode {

  case coreText
  case textKit

  public static var `default`: StringSizeCalculationMode { return .coreText }

}

private let stringSizeCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
  let cache = NSCache<AnyObject, AnyObject>()
  let selector = #selector(type(of: cache).removeAllObjects)
  let name = UIApplication.didReceiveMemoryWarningNotification
  NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
  return cache
}()

public extension String {

  func sizeWith(fixedWidth: CGFloat, with font: UIFont, mode: StringSizeCalculationMode = .default) -> CGSize {
    return NSAttributedString(string: self, attributes: [.font: font])
      .sizeWith(fixedWidth: fixedWidth, mode: mode)
  }

  func sizeWith(fixedHeight: CGFloat, with font: UIFont, mode: StringSizeCalculationMode = .default) -> CGSize {
    return NSAttributedString(string: self, attributes: [.font: font])
      .sizeWith(fixedHeight: fixedHeight, mode: mode)
  }

  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
    let boundingBox = self.boundingRect(with: constraintRect, options: options, attributes: [.font: font], context: nil)
    return boundingBox.height
  }
}

// MARK: - NSAttributedString

public extension NSAttributedString {

  // MARK: Size rendering

  func sizeWith(fixedWidth: CGFloat, mode: StringSizeCalculationMode = .default) -> CGSize {
    let size = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
    let key = size.hashValue ^ hashValue
    if let cachedValue = stringSizeCache.object(forKey: key as AnyObject) as? NSValue {
      return cachedValue.cgSizeValue
    }

    let result = framesetterLayoutSize(with: size)
    stringSizeCache.setObject(NSValue(cgSize: result), forKey: key as AnyObject)
    return result
  }

  func sizeWith(fixedHeight: CGFloat, mode: StringSizeCalculationMode = .default) -> CGSize {
    let size = CGSize(width: .greatestFiniteMagnitude, height: fixedHeight)
    let key = size.hashValue ^ hashValue
    if let cachedValue = stringSizeCache.object(forKey: key as AnyObject) as? NSValue {
      return cachedValue.cgSizeValue
    }

    let result = framesetterLayoutSize(with: size)
    stringSizeCache.setObject(NSValue(cgSize: result), forKey: key as AnyObject)
    return result
  }

}

// MARK: - Private

private extension NSAttributedString {

  func framesetterLayoutSize(with fitSize: CGSize) -> CGSize {
    guard length > 0 else { return .zero }

    let attrString = self as CFAttributedString
    let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attrString)
    var fitRange = CFRange()
    let totalRange = CFRangeMake(0, length)
    let frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, totalRange, nil, fitSize, &fitRange)
    return frameSize
  }

  func layoutSize(with bounds: CGSize) -> CGSize {
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
