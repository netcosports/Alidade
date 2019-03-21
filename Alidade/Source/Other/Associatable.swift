//
//  Associatable.swift
//  Utility
//
//  Created by Dmitry Duleba on 1/8/18.
//

import Foundation

// MARK: - Associatable

public protocol Associatable {

  var associated: Associated<AnyObject> { get }
}

public extension Associatable where Self: AnyObject {

  var associated: Associated<AnyObject> { return Associated(base: self) }
}

extension NSObject: Associatable { }

// MARK: - Associated

public struct Associated<T> {

  public let base: T

  fileprivate init(base: T) {
    self.base = base
  }
}

public extension Associated where T: AnyObject {

  func set<U: Any>(_ value: U?, for associativeKey: UnsafeRawPointer,
                   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    Associator.set(value, in: base, for: associativeKey, policy: policy)
  }

  func value<U>(for associativeKey: UnsafeRawPointer) -> U? {
    return Associator.value(from: base, for: associativeKey)
  }

  func readonlyValue<U>(for associativeKey: UnsafeRawPointer, initialValue: () -> U) -> U {
    let value: U? = self.value(for: associativeKey)
    if let value = value {
      return value
    }
    let instance = initialValue()
    set(instance, for: associativeKey)
    return instance
  }
}

// MARK: - Associator

final private class Associator {

  private init() { }

  class func set<T: Any>(_ value: T?, in object: AnyObject, for associativeKey: UnsafeRawPointer,
                         policy: objc_AssociationPolicy) {
    if isRefType(value) {
      objc_setAssociatedObject(object, associativeKey, value, policy)
    } else {
      objc_setAssociatedObject(object, associativeKey, Boxed(value), policy)
    }
  }

  class func value<T>(from object: AnyObject, for associativeKey: UnsafeRawPointer) -> T? {
    if let value = objc_getAssociatedObject(object, associativeKey) as? T {
      return value
    } else if let value = objc_getAssociatedObject(object, associativeKey) as? Boxed<T> {
      return value.value
    }
    return nil
  }

  private class func isRefType<T: Any>(_ value: T) -> Bool {
    return type(of: value).self is AnyClass
  }
}
