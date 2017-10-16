//
//  UIViewExtension.swift
//
//  Created by Alexey Zhemblovskiy on 4/21/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import UIKit

public extension UIView {

  var height: CGFloat { return frame.height }
  var width: CGFloat { return frame.width }

  // swiftlint:disable identifier_name
  var x: CGFloat { return frame.minX }
  var y: CGFloat { return frame.minY }
  // swiftlint:enable identifier_name

  func addSubviews(_ subviews: [UIView]) {
    subviews.forEach {
      addSubview($0)
    }
  }

  func removeLayoutGuides(with identifier: String?) {
    if let identifier = identifier {
      layoutGuides
        .filter { $0.identifier == identifier }
        .forEach { removeLayoutGuide($0) }
    } else {
      layoutGuides.forEach {
        removeLayoutGuide($0)
      }
    }
  }
}

public extension UIView {

  func makeNotHuggable(in directions: [UILayoutConstraintAxis] = [.horizontal, .vertical]) {
    directions.forEach {
      setContentHuggingPriority(UILayoutPriority.required, for: $0)
    }
  }

  func makeNotCompressable(in directions: [UILayoutConstraintAxis] = [.horizontal, .vertical]) {
    directions.forEach {
      setContentCompressionResistancePriority(UILayoutPriority.required, for: $0)
    }
  }
}
