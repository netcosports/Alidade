//
//  Boxed.swift
//
//  Created by Dmitry Duleba on 10/4/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

public class Boxed<T> {

  public var value: T?

  public init(_ value: T? = nil) {
    self.value = value
  }

  public func flatMap<U>(_ transform: (T) -> U?) -> U? {
    return value.flatMap(transform)
  }
}
