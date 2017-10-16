//
//  FormatterPool.swift
//
//  Created by Dmitry Duleba on 5/8/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public protocol Formatter: class {

  associatedtype Format

  var format: Format { get set }
  var locale: Locale! { get set }

  init()

  static func hashValue(format: Format, locale: Locale) -> Int
}

public extension Locale {

  public static let enUSPosix = Locale(identifier: "en_US_POSIX")
}

public final class FormatterPool {

  fileprivate init() { }

  fileprivate static let cache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
    let cache = NSCache<AnyObject, AnyObject>()
    let selector = #selector(NSCache<AnyObject, AnyObject>.removeAllObjects)
    let name = NSNotification.Name.UIApplicationDidReceiveMemoryWarning
    NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
    return cache
  }()

  public static func formatter<T: Formatter>(_ type: T.Type, format: T.Format, locale: Locale = .current) -> T {
    let key = T.hashValue(format: format, locale: locale)
    if let formatter = cache.object(forKey: key as AnyObject) as? T {
      return formatter
    }
    let formatter = T.init()
    formatter.format = format
    formatter.locale = locale
    cache.setObject(formatter, forKey: key as AnyObject)
    return formatter
  }
}

// MARK: - DateFormatter

extension DateFormatter: Formatter {

  public typealias Format = String

  public var format: String {
    get { return dateFormat }
    set { dateFormat = newValue }
  }

  public static func hashValue(format: Format, locale: Locale = .current) -> Int {
    return format.hashValue ^ locale.identifier.hashValue
  }
}

// MARK: - NumberFormatter

extension NumberFormatter: Formatter {

  public typealias Format = Style

  public static func hashValue(format: Format, locale: Locale = .current) -> Int {
    return format.hashValue ^ locale.identifier.hashValue
  }

  public var format: Style {
    get { return numberStyle }
    set { numberStyle = newValue }
  }
}
