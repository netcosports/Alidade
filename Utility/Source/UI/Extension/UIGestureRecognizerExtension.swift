//
//  UIGestureRecognizerExtension.swift
//
//  Created by Dmitry Duleba on 5/16/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension UIGestureRecognizer {

  public func removeFromView() {
    view?.removeGestureRecognizer(self)
  }

  public func cancel() {
    guard isEnabled else { return }

    isEnabled = false
    isEnabled = true
  }
}
