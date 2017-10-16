//
//  SequenceExtension.swift
//  Utility
//
//  Created by Dmitry Duleba on 9/27/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension Sequence {

  func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
    let result = Dictionary(grouping: self) { key($0) }
    return result
  }
}
