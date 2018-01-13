//
//  Flowable.swift
//  Utility
//
//  Created by Dmitry Duleba on 1/6/18.
//  Copyright © 2018 NetcoSports. All rights reserved.
//

import Foundation

extension NSObject: Flowable { }

public protocol Flowable { }

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
