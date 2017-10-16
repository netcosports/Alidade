//
//  BoolExtension.swift
//  TourDeFrance
//
//  Created by Alexey Zhemblovskiy on 5/6/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension Bool {
  static var random: Bool {
    return arc4random_uniform(2) == 0
  }
}
