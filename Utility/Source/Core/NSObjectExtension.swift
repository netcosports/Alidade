//
//  NSObjectExtension.swift
//  TourDeFrance
//
//  Created by Dmitry Duleba on 4/30/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension NSObjectProtocol {

  static var className: String { return NSStringFromClass(self) }
  var className: String { return type(of: self).className }
}
