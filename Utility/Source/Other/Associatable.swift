//
//  Associatable.swift
//  Utility
//
//  Created by Dmitry Duleba on 1/8/18.
//  Copyright © 2018 NetcoSports. All rights reserved.
//

import Foundation

import ObjectiveC

// MARK: - Associatable

protocol Associatable {

  var associated: Associated<AnyObject> { get }
}

extension Associatable where Self: AnyObject {

  var associated: Associated<AnyObject> { return Associated(base: self) }
}

extension NSObject: Associatable { }

// MARK: - Associated

struct Associated<T> {

  let base: T

  fileprivate init(base: T) {
    self.base = base
  }
}

extension Associated where T: AnyObject {

  func set<U: Any>(_ value: U?, for associativeKey: UnsafeRawPointer,
                   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    Associator.set(value, in: base, for: associativeKey, policy: policy)
  }

  func value<U>(for associativeKey: UnsafeRawPointer) -> U? {
    return Associator.value(from: base, for: associativeKey)
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
    if let v = objc_getAssociatedObject(object, associativeKey) as? T {
      return v
    } else if let v = objc_getAssociatedObject(object, associativeKey) as? Boxed<T> {
      return v.value
    }
    return nil
  }

  // Actually no: it returns false for value types
  private class func isRefType<T: Any>(_ value: T) -> Bool {
    return type(of: value).self is AnyObject
  }
}
