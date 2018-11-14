//
//  Flowable.swift
//  Utility
//
//  Created by Dmitry Duleba on 1/6/18.
//

import Foundation

extension NSObject: Flowable, Initiable { }

public protocol Flowable { }
public protocol Initiable {

  init()
}

extension Flowable where Self: Initiable {

  public init(with constructor: (Self) -> Void) {
    self.init()
    constructor(self)
  }
}

public extension Flowable {

  @discardableResult
  public func with(_ transformer: (Self) -> Void) -> Self {
    transformer(self)
    return self
  }

  public func map<U>(_ transformer: (Self) throws -> U) rethrows -> U {
    return try transformer(self)
  }
}

public extension Optional where Wrapped: Any {

  @discardableResult
  public func with(_ transformer: (Wrapped) -> Void) -> Optional {
    flatMap { transformer($0) }
    return self
  }
}
