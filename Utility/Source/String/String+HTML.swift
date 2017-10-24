//
//  String+HTML.swift
//  Utility
//
//  Created by Dmitry Duleba on 10/24/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

private let htmlToPlainStringCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
  let cache = NSCache<AnyObject, AnyObject>()
  let selector = #selector(NSCache<AnyObject, AnyObject>.removeAllObjects)
  let name = NSNotification.Name.UIApplicationDidReceiveMemoryWarning
  NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
  return cache
}()

public extension String {
  
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
}
