import Foundation

public protocol Formatter: class {

  associatedtype Format
  associatedtype PoolInstance: Formatter

  var format: Format { get set }
  var locale: Locale! { get set }

  init()

  static func hashValue(format: Format, locale: Locale) -> Int
  static func cached(format: Format, locale: Locale) -> PoolInstance
}

public extension Locale {

  public static let enUSPosix = Locale(identifier: "en_US_POSIX")
}

fileprivate final class FormatterPool {

  private init() { }

  private static let cache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
    let cache = NSCache<AnyObject, AnyObject>()
    let selector = #selector(NSCache<AnyObject, AnyObject>.removeAllObjects)
    let name = NSNotification.Name.UIApplicationDidReceiveMemoryWarning
    NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
    return cache
  }()

  fileprivate static func formatter<T: Formatter>(format: T.Format, locale: Locale = .current) -> T {
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
  public typealias PoolInstance = DateFormatter

  public var format: String {
    get { return dateFormat }
    set { dateFormat = newValue }
  }

  public static func hashValue(format: Format, locale: Locale = .current) -> Int {
    return format.hashValue ^ locale.identifier.hashValue
  }

  public static func cached(format: String, locale: Locale = .current) -> DateFormatter {
    return FormatterPool.formatter(format: format, locale: locale)
  }
}

// MARK: - NumberFormatter

extension NumberFormatter: Formatter {

  public typealias PoolInstance = NumberFormatter
  public typealias Format = Style

  public var format: Style {
    get { return numberStyle }
    set { numberStyle = newValue }
  }

  public static func hashValue(format: Format, locale: Locale = .current) -> Int {
    return format.hashValue ^ locale.identifier.hashValue
  }

  public static func cached(format: NumberFormatter.Style, locale: Locale = .current) -> NumberFormatter {
    return FormatterPool.formatter(format: format, locale: locale)
  }
}
