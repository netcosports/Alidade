import Foundation

// MARK: - LocalizedFormatter

public protocol LocalizedFormatter: Formatter {

  var locale: Locale! { get set }

  static func hashValue(format: Format, locale: Locale) -> Int
  static func cached(format: Format, locale: Locale) -> PoolInstance
}

public extension LocalizedFormatter {

  public static func hashValue(format: Format) -> Int {
    return hashValue(format: format, locale: .current)
  }

  public static func cached(format: Format) -> PoolInstance {
    return cached(format: format, locale: .current)
  }
}

// MARK: - Formatter

public protocol Formatter: class {

  associatedtype Format
  associatedtype PoolInstance: Formatter

  var format: Format { get set }

  init()

  static func hashValue(format: Format) -> Int
  static func cached(format: Format) -> PoolInstance
}

public extension Locale {

  public static let enUSPosix = Locale(identifier: "en_US_POSIX")
}

fileprivate final class FormatterPool {

  private init() { }

  private static let cache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
    let cache = NSCache<AnyObject, AnyObject>()
    let selector = #selector(NSCache<AnyObject, AnyObject>.removeAllObjects)
    let name = UIApplication.didReceiveMemoryWarningNotification
    NotificationCenter.default.addObserver(cache, selector: selector, name: name, object: nil)
    return cache
  }()

  fileprivate static func formatter<T: Formatter>(format: T.Format) -> T {
    let key = T.hashValue(format: format)
    if let formatter = cache.object(forKey: key as AnyObject) as? T {
      return formatter
    }
    let formatter = T.init()
    formatter.format = format
    cache.setObject(formatter, forKey: key as AnyObject)
    return formatter
  }

  fileprivate static func formatter<T: LocalizedFormatter>(format: T.Format, locale: Locale = .current) -> T {
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

extension DateFormatter: LocalizedFormatter {

  public typealias PoolInstance = DateFormatter
  public typealias Format = String

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

extension NumberFormatter: LocalizedFormatter {

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

// MARK: - ByteCountFormatter

extension ByteCountFormatter: Formatter {

  public typealias PoolInstance = ByteCountFormatter
  public struct Format {
    let units: Units
    let style: CountStyle

    public init(units: Units = .useAll, style: CountStyle = .file) {
      self.units = units
      self.style = style
    }
  }

  public var format: Format {
    get { return .init(units: allowedUnits, style: countStyle) }
    set { allowedUnits = newValue.units; countStyle = newValue.style }
  }

  public static func hashValue(format: Format) -> Int {
    return format.style.hashValue ^ format.units.rawValue.hashValue
  }

  public static func cached(format: Format) -> ByteCountFormatter {
    return FormatterPool.formatter(format: format)
  }

}

// MARK: - DateComponentsFormatter

extension DateComponentsFormatter: Formatter {

  public typealias PoolInstance = DateComponentsFormatter
  public struct Format {
    let units: NSCalendar.Unit
    let style: UnitsStyle

    public init(units: NSCalendar.Unit = .init(rawValue: 0), style: UnitsStyle = .positional) {
      self.units = units
      self.style = style
    }
  }

  public var format: Format {
    get { return .init(units: allowedUnits, style: unitsStyle) }
    set { allowedUnits = newValue.units; unitsStyle = newValue.style }
  }

  public static func hashValue(format: Format) -> Int {
    return format.style.hashValue ^ format.units.rawValue.hashValue
  }

  public static func cached(format: Format) -> DateComponentsFormatter {
    return FormatterPool.formatter(format: format)
  }

}

// MARK: - DateIntervalFormatter

extension DateIntervalFormatter: LocalizedFormatter {

  public typealias PoolInstance = DateIntervalFormatter
  public typealias Format = String

  public var format: Format {
    get { return dateTemplate }
    set { dateTemplate = newValue }
  }

  public static func hashValue(format: String, locale: Locale = .current) -> Int {
    return format.hashValue ^ locale.hashValue
  }

  public static func cached(format: Format, locale: Locale = .current) -> DateIntervalFormatter {
    return FormatterPool.formatter(format: format, locale: locale)
  }

}

// MARK: - EnergyFormatter

extension EnergyFormatter: Formatter {

  public typealias PoolInstance = EnergyFormatter
  public typealias Format = UnitStyle

  public var format: Format {
    get { return unitStyle }
    set { unitStyle = newValue }
  }

  public static func hashValue(format: Format) -> Int {
    return format.hashValue ^ 428936712512
  }

  public static func cached(format: Format) -> EnergyFormatter {
    return FormatterPool.formatter(format: format)
  }

}
