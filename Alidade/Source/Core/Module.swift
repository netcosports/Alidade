//
//  Module.swift
//  Alidade
//
//  Created by Dmitry Duleba on 11/13/18.
//  Copyright © 2018 NetcoSports. All rights reserved.
//

import Foundation

public struct Module: Hashable, CustomDebugStringConvertible, CustomStringConvertible {

  private let dso: UnsafeRawPointer

  public init(_ dso: UnsafeRawPointer = #dsohandle) {
    self.dso = dso
  }

  public var name: String {
    var dlInformation: dl_info = dl_info()
    _ = dladdr(dso, &dlInformation)
    let path = String(cString: dlInformation.dli_fname)
    return URL(fileURLWithPath: path).lastPathComponent
  }

  public var debugDescription: String {
    return name
  }

  public var description: String {
    return name
  }

}
