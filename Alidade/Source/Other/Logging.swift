//
//  NSObject+Logging.swift
//  Alidade
//
//  Created by Dmitry Duleba on 11/14/18.
//

import Foundation

public extension NSObject {

  func fullClassName(shoulShowModuleName: Bool = false, dso: UnsafeRawPointer = #dsohandle) -> String {
    return type(of: self).fullClassName(shoulShowModuleName: shoulShowModuleName, dso: dso)
  }

  class func fullClassName(shoulShowModuleName: Bool = false, dso: UnsafeRawPointer = #dsohandle) -> String {
    let moduleName = Module(dso).name
    var name = description()
    if let moduleRange = name.range(of: moduleName), moduleRange.lowerBound > name.startIndex {
      let removeRange = name.startIndex..<moduleRange.lowerBound
      name.removeSubrange(removeRange)
    }

    if !shoulShowModuleName, let moduleRange = name.range(of: moduleName) {
      name.removeSubrange(moduleRange)
    }

    let result = name.components(separatedBy: CharacterSet.letters.inverted)
      .filter { $0.count > 0 }
      .joined(separator: ".")
    return result
  }

}

public extension Error {

  func log() { print("❌ \(localizedDescription)") }

}
