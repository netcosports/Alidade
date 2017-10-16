//
//  UIView+Debug.swift
//
//  Created by Dmitry Duleba on 5/25/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension UIView {

  func scrollViewsInSubviews() -> [UIScrollView] {
    return subviews.flatMap {
      [($0 as? UIScrollView)].flatMap { $0 } + $0.scrollViewsInSubviews()
    }
  }
}
