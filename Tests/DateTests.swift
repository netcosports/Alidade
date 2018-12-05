//
//  DateTests.swift
//  Tests
//
//  Created by Vladimir Burdukov on 10/5/17.
//
//

import XCTest
import Nimble
import Alidade

class DateSpec: XCTestCase {

  let timeZone = TimeZone(identifier: "Europe/Minsk")

  func testInitializer() {
    let month = Date(year: 2016, month: 7, in: timeZone)
    expect(month.timeIntervalSinceReferenceDate) == 489013200

    let day = Date(year: 2016, month: 7, day: 31, in: timeZone)
    expect(day.timeIntervalSinceReferenceDate) == 491605200

    let hour = Date(year: 2016, month: 7, day: 31, hour: 12, in: timeZone)
    expect(hour.timeIntervalSinceReferenceDate) == 491648400

    let minute = Date(year: 2016, month: 7, day: 31, hour: 12, minute: 35, in: timeZone)
    expect(minute.timeIntervalSinceReferenceDate) == 491650500

    let second = Date(year: 2016, month: 7, day: 31, hour: 12, minute: 35, second: 23, in: timeZone)
    expect(second.timeIntervalSinceReferenceDate) == 491650523
  }

  func testComponents() {
    expect(10.seconds.second) == 10
    expect(9.minutes.minute) == 9
    expect(8.hours.hour) == 8
    expect(7.days.day) == 7
    expect(6.weeks.weekOfYear) == 6
    expect(5.months.month) == 5
    expect(4.years.year) == 4

    let components = 3.hours & 30.minutes
    expect(components.hour) == 3
    expect(components.minute) == 30
  }

  func testAddition() {
    let add = Date(year: 2016, month: 7, day: 31, hour: 12) + 1.minutes & 30.seconds
    expect(add) == Date(year: 2016, month: 7, day: 31, hour: 12, minute: 1, second: 30)

    let subtract = Date(year: 2017, month: 2, day: 21) - 14.days
    expect(subtract) == Date(year: 2017, month: 2, day: 7)
  }

  func testStartOf() {
    let date = Date(year: 2016, month: 7, day: 31, hour: 12, minute: 22, second: 20, nanosecond: 323)
    print(date.timeIntervalSince1970)
    expect(date.start(of: .hour)) == Date(year: 2016, month: 7, day: 31, hour: 12, minute: 0)
    expect(date.start(of: .day)) == Date(year: 2016, month: 7, day: 31)
    expect(date.start(of: .month)) == Date(year: 2016, month: 7, day: 1)
    expect(date.start(of: .minute)) == Date(year: 2016, month: 7, day: 31, hour: 12, minute: 22, second: 0)
    expect(date.start(of: .second)) == Date(year: 2016, month: 7, day: 31, hour: 12, minute: 22, second: 20)

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    guard let fractional = formatter.date(from: "2017-06-19T12:02:48.363Z") else { return fail() }
    expect(formatter.string(from: fractional)) == "2017-06-19T12:02:48.363Z"
    expect(formatter.string(from: fractional.start(of: .second))) == "2017-06-19T12:02:48.000Z"
    expect(formatter.string(from: fractional.start(of: .minute))) == "2017-06-19T12:02:00.000Z"
  }

  func testEndOf() {
    let date = Date(year: 2016, month: 7, day: 15, hour: 12, minute: 22)
    expect(date.end(of: .hour).timeIntervalSinceReferenceDate).to(beCloseTo(Date(
      year: 2016, month: 7, day: 15, hour: 13).timeIntervalSinceReferenceDate, within: 0.001))
    expect(date.end(of: .day).timeIntervalSinceReferenceDate).to(beCloseTo(Date(
      year: 2016, month: 7, day: 16).timeIntervalSinceReferenceDate, within: 0.001))
    expect(date.end(of: .month).timeIntervalSinceReferenceDate).to(beCloseTo(Date(
      year: 2016, month: 8, day: 1).timeIntervalSinceReferenceDate, within: 0.001))
  }

  func testYesterday() {
    expect(Date.yesterday) ==
      Calendar.current.startOfDay(for: Date()).addingTimeInterval(-86400)
    expect((Date() - 1.days).isInYesterday).to(beTruthy())
    expect(Date().isInYesterday).to(beFalsy())
  }

  func testToday() {
    expect(Date.today) == Calendar.current.startOfDay(for: Date())
    expect(Date().isInToday).to(beTruthy())
    expect((Date() - 1.days).isInToday).to(beFalsy())
  }

  func testTomorrow() {
    expect(Date.tomorrow) ==
      Calendar.current.startOfDay(for: Date()).addingTimeInterval(86400)
    expect((Date() + 1.days).isInTomorrow).to(beTruthy())
    expect(Date().isInTomorrow).to(beFalsy())
  }

  func testSameDay() {
    let date = Date(year: 2016, month: 7, day: 15, hour: 12, minute: 22)
    expect(date.isSameDay(as: date.start(of: .day))).to(beTruthy())
    expect(date.isSameDay(as: date.end(of: .day))).to(beTruthy())
    expect(date.isSameDay(as: date.start(of: .day) + 1.days)).to(beFalsy())
  }

  func testStringToDate() {
    expect("2016-03-06 19:00:00".toDate(format: "yyyy-MM-dd HH:mm:ss", timeZone: "GMT")) ==
      Date(year: 2016, month: 3, day: 6, hour: 22, minute: 0, in: timeZone)
    expect("2016-03-06 19:00:00".toDate(format: "yyyy-MM-dd HH:mm:ss")) ==
      Date(year: 2016, month: 3, day: 6, hour: 19, minute: 0)
  }

  func testDateToString() {
    let date = Date(year: 2016, month: 3, day: 6, hour: 22, minute: 0)
    expect(date.toString()) == "2016-03-06 22:00:00"
    expect(date.toString(format: "yy/M/d HH:mm")) == "16/3/6 22:00"

    let formatter = DateFormatter()
    formatter.dateFormat = DateFormatter.dateFormat(
      fromTemplate: "yyMdjjmm", options: 0, locale: Locale(identifier: "en_US"))
    expect(formatter.string(from: date)) == "3/6/16, 10:00 PM"
  }

  func testDifference() {
    let first = Date(year: 2016, month: 8, day: 16, hour: 16, minute: 30)
    let second = Date(year: 2016, month: 8, day: 21, hour: 17, minute: 45)
    let result = first.difference(date: second, unitFlags: [.day, .minute])
    let components = DateComponents(calendar: nil, timeZone: nil, era: nil, year: nil, month: nil, day: 5,
                                    hour: nil, minute: 75, second: nil, nanosecond: nil,
                                    weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil,
                                    weekOfYear: nil, yearForWeekOfYear: nil)
    expect(result) == components
  }

  func testWeekdayFoundationMapping() {
    expect(Weekday.monday.foundationValue) == 2
    expect(Weekday.tuesday.foundationValue) == 3
    expect(Weekday.wednesday.foundationValue) == 4
    expect(Weekday.thursday.foundationValue) == 5
    expect(Weekday.friday.foundationValue) == 6
    expect(Weekday.saturday.foundationValue) == 7
    expect(Weekday.sunday.foundationValue) == 1
  }

}
