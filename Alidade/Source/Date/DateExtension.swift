//
//  DateExtension.swift
//  Alidade
//
//  Created by Vladimir Burdukov on 8/26/16.
//  Added by Dmitry Duleba on 12/6/18.
//

import Foundation

public extension Date {

  enum Context {

    public static var calendar = Calendar.autoupdatingCurrent

  }
}

// MARK: - Start/End

public extension Date {

  func start(of unit: Calendar.Component) -> Date {
    var date = Date()
    var interval: TimeInterval = 0
    guard Context.calendar.dateInterval(of: unit, start: &date, interval: &interval, for: self) else {
      assertionFailure()
      return date
    }

    return date
  }

  func end(of unit: Calendar.Component) -> Date {
    var date = Date()
    var interval: TimeInterval = 0
    guard Context.calendar.dateInterval(of: unit, start: &date, interval: &interval, for: self) else {
      assertionFailure()
      return date
    }

    interval -= 0.001
    return date.addingTimeInterval(interval)
  }

}

// MARK: - Initializers

public extension Date {

  init(year: Int, month: Int, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0,
       nanosecond: Int = 0, `in` timeZone: TimeZone? = nil) {
    var components = DateComponents(calendar: Context.calendar)
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.nanosecond = nanosecond
    components.timeZone = timeZone
    guard let result = Context.calendar.date(from: components) else {
      self.init(timeIntervalSinceReferenceDate: 0)
      return
    }
    self.init(timeIntervalSinceReferenceDate: result.timeIntervalSinceReferenceDate)
  }

  static var yesterday: Date {
    return today - 1.days
  }

  var yesterday: Date {
    return self - 1.days
  }

  static var today: Date {
    return Date().start(of: .day)
  }

  static var tomorrow: Date {
    return today + 1.days
  }

  var tomorrow: Date {
    return self + 1.days
  }

  var isInYesterday: Bool {
    return Context.calendar.isDateInYesterday(self)
  }

  var isInToday: Bool {
    return Context.calendar.isDateInToday(self)
  }

  var isInTomorrow: Bool {
    return Context.calendar.isDateInTomorrow(self)
  }

  func isSameDay(as date: Date) -> Bool {
    return Context.calendar.isDate(self, inSameDayAs: date)
  }

}

// MARK: - Formatting

public extension TimeZone {

  @nonobjc static let UTC = TimeZone(abbreviation: "UTC")

}

public extension Date {

  static func date(fromString str: String, dateFormatter formatter: DateFormatter, timezone: String? = nil) ->
    Date? {
      if let timezone = timezone {
        formatter.timeZone = TimeZone(abbreviation: timezone)
      }

      return formatter.date(from: str)
  }

  static func date(fromString str: String, format: String, timezone: String? = nil, locale: Locale? = nil) ->
    Date? {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      if let locale = locale {
        dateFormatter.locale = locale
      } else {
        dateFormatter.locale = Locale.enUSPosix
      }

      return date(fromString: str, dateFormatter: dateFormatter, timezone: timezone)
  }

  func toString(formatter: DateFormatter) -> String {
    return formatter.string(from: self)
  }

  func toString(format: String = "yyyy-MM-dd HH:mm:ss", locale: Locale? = nil) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = locale != nil ? locale : Locale.enUSPosix
    return toString(formatter: formatter)
  }

}

public extension String {

  func toDate(dateFormatter formatter: DateFormatter, timeZone: String? = nil) -> Date? {
    return Date.date(fromString: self, dateFormatter: formatter, timezone: timeZone)
  }

  func toDate(format: String, timeZone: String? = nil, locale: Locale? = nil) -> Date? {
    return Date.date(fromString: self, format: format, timezone: timeZone, locale: locale)
  }

}

// MARK: - Int components

public extension Int {

  var seconds: DateComponents {
    var components = DateComponents()
    components.second = self
    return components
  }

  var minutes: DateComponents {
    var components = DateComponents()
    components.minute = self
    return components
  }

  var hours: DateComponents {
    var components = DateComponents()
    components.hour = self
    return components
  }

  var days: DateComponents {
    var components = DateComponents()
    components.day = self
    return components
  }

  var weeks: DateComponents {
    var components = DateComponents()
    components.weekOfYear = self
    return components
  }

  var months: DateComponents {
    var components = DateComponents()
    components.month = self
    return components
  }

  var years: DateComponents {
    var components = DateComponents()
    components.year = self
    return components
  }

}

// MARK: - Date components

public enum Weekday: Int {
  case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday

  public var foundationValue: Int {
    return (rawValue + 1) % 7 + 1
  }
}

public extension Date {

  var second: Int {
    return Date.Context.calendar.component(.second, from: self)
  }

  var minute: Int {
    return Date.Context.calendar.component(.minute, from: self)
  }

  var hour: Int {
    return Date.Context.calendar.component(.hour, from: self)
  }

  var day: Int {
    return Date.Context.calendar.component(.day, from: self)
  }

  var month: Int {
    return Date.Context.calendar.component(.month, from: self)
  }

  var year: Int {
    return Date.Context.calendar.component(.year, from: self)
  }

  var weekday: Weekday {
    guard let weekday = Weekday(rawValue: (Date.Context.calendar.component(.weekday, from: self) + 12) % 7) else {
      assertionFailure()
      return .monday
    }
    return weekday
  }

}

// MARK: - Operators

public func + (lhs: Date, rhs: DateComponents) -> Date {
  guard let result = Date.Context.calendar.date(byAdding: rhs, to: lhs) else {
    assertionFailure("can't add components \(rhs) to date \(lhs)")
    return Date()
  }

  return result
}

public func - (lhs: Date, rhs: DateComponents) -> Date {
  return lhs + (-rhs)
}

private let components: [Calendar.Component] = [
  .nanosecond, .second, .minute, .hour, .day, .month, .year,
  .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal, .weekOfMonth]

public prefix func - (comp: DateComponents) -> DateComponents {
  var other = comp
  for component in components {
    guard let value = comp.value(for: component), value != NSNotFound else { continue }
    other.setValue(-value, for: component)
  }

  return other
}

public func & (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
  var new = lhs
  for component in components {
    guard let value1 = lhs.value(for: component), let value2 = rhs.value(for: component) else { continue }
    switch (value1, value2) {
    case (NSNotFound, NSNotFound):
      continue
    case (_, NSNotFound):
      continue
    case (NSNotFound, let value):
      new.setValue(value, for: component)
    case (let value1, let value2):
      new.setValue(value1 + value2, for: component)
    }
  }

  return new
}

// MARK: - Difference

public extension Date {

  func difference(date: Date, unitFlags: Set<Calendar.Component>) -> DateComponents? {
    return Date.Context.calendar.dateComponents(unitFlags, from: self, to: date)
  }

}

// MARK: - Comparison

public func < (lhs: Date?, rhs: Date?) -> Bool {
  guard let lhs = lhs else { return true }
  guard let rhs = rhs else { return false }
  return lhs < rhs
}

public func < (lhs: Date, rhs: Date?) -> Bool {
  guard let rhs = rhs else { return false }
  return lhs < rhs
}

public func < (lhs: Date?, rhs: Date) -> Bool {
  guard let lhs = lhs else { return true }
  return lhs < rhs
}

public func > (lhs: Date?, rhs: Date?) -> Bool {
  guard let lhs = lhs else { return false }
  guard let rhs = rhs else { return true }
  return lhs > rhs
}

public func > (lhs: Date, rhs: Date?) -> Bool {
  guard let rhs = rhs else { return true }
  return lhs > rhs
}

public func > (lhs: Date?, rhs: Date) -> Bool {
  guard let lhs = lhs else { return false }
  return lhs > rhs
}
