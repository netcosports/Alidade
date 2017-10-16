//
//  UIScrollViewExtension.swift
//
//  Created by Dmitry Duleba on 5/15/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import UIKit

public extension UIScrollView {

  public enum Position {
    case top
    case left
    case right
    case bottom
  }

  public func isCurrently(at position: Position) -> Bool {
    let offset = contentOffset(for: position)
    return offset == self.contentOffset
  }

  public func scroll(to position: Position, animated: Bool) {
    let offset = contentOffset(for: position)
    setContentOffset(offset, animated: animated)
  }

  fileprivate func contentOffset(for position: Position) -> CGPoint {
    let offset: CGPoint
    switch position {
    case .top:    offset = CGPoint(x: contentOffset.x, y: -contentInset.top)
    case .left:   offset = CGPoint(x: -contentInset.left, y: contentOffset.y)
    case .right:  offset = CGPoint(x: contentSize.width - bounds.size.width, y: contentOffset.y)
    case .bottom: offset = CGPoint(x: contentOffset.x, y: contentSize.height - bounds.size.height)
    }
    return offset
  }
}
