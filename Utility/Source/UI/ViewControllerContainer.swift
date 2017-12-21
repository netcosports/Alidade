//
//  UIViewController.swift
//  Utility
//
//  Created by Dmitry Duleba on 11/15/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation
import UIKit

public struct ViewControllerContainer<Base> {

  public let base: Base

  public init(_ base: Base) {
    self.base = base
  }
}

public protocol ViewControllerContainerCompatible {

  associatedtype CompatibleType

  static func asContainer() -> ViewControllerContainer<CompatibleType>.Type
  func asContainer() -> ViewControllerContainer<CompatibleType>
}

public extension ViewControllerContainerCompatible {

  public static func asContainer() -> ViewControllerContainer<Self>.Type {
    return ViewControllerContainer<Self>.self
  }

  public func asContainer() -> ViewControllerContainer<Self> {
    return ViewControllerContainer(self)
  }
}

public extension ViewControllerContainer where Base: UIViewController {

  public func add(_ childViewController: UIViewController?, to containerView: UIView, animated: Bool) {
    guard let childViewController = childViewController else { return }

    base.addChildViewController(childViewController)
    childViewController.beginAppearanceTransition(true, animated: animated)
    containerView.addSubview(childViewController.view)
    childViewController.view.fillSuperview()
    childViewController.didMove(toParentViewController: base)
    if !animated {
      childViewController.endAppearanceTransition()
    }
  }

  public func remove(_ childViewController: UIViewController?, animated: Bool) {
    guard let childViewController = childViewController else { return }

    childViewController.willMove(toParentViewController: nil)
    childViewController.view.removeFromSuperview()
    childViewController.beginAppearanceTransition(false, animated: animated)
    childViewController.removeFromParentViewController()
    if !animated {
      childViewController.endAppearanceTransition()
    }
  }
}

extension UIView {

  func fillSuperview() {
    guard let superview = superview else {
      return
    }

    translatesAutoresizingMaskIntoConstraints = false
    let attributes: [NSLayoutAttribute] = [.width, .height, .top, .leading]
    attributes
      .map { NSLayoutConstraint(item: self, attribute: $0, relatedBy: .equal,
                                toItem: superview, attribute: $0, multiplier: 1.0, constant: 0.0) }
      .forEach { superview.addConstraint($0) }
  }
}
