//
//  UIViewController.swift
//  Utility
//
//  Created by Dmitry Duleba on 11/15/17.
//

import Foundation
import UIKit

extension UIViewController: ViewControllerContainerCompatible { }

public struct ViewControllerContainer<Base> {

  let base: Base

  init(_ base: Base) {
    self.base = base
  }
}

public protocol ViewControllerContainerCompatible {

  associatedtype CompatibleType

  func asContainer() -> ViewControllerContainer<CompatibleType>
}

public extension ViewControllerContainerCompatible {

  func asContainer() -> ViewControllerContainer<Self> {
    return ViewControllerContainer(self)
  }
}

public extension ViewControllerContainer where Base: UIViewController {

  func add(_ childViewController: UIViewController?, to containerView: UIView, animated: Bool) {
    guard let childViewController = childViewController else { return }

    base.addChild(childViewController)
    childViewController.beginAppearanceTransition(true, animated: animated)
    containerView.addSubview(childViewController.view)
    childViewController.view.fillSuperview()
    childViewController.didMove(toParent: base)
    if !animated {
      childViewController.endAppearanceTransition()
    }
  }

  func remove(_ childViewController: UIViewController?, animated: Bool) {
    guard let childViewController = childViewController else { return }

    childViewController.willMove(toParent: nil)
    childViewController.view.removeFromSuperview()
    childViewController.beginAppearanceTransition(false, animated: animated)
    childViewController.removeFromParent()
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
    let attributes: [NSLayoutConstraint.Attribute] = [.width, .height, .top, .leading]
    attributes
      .map { NSLayoutConstraint(item: self, attribute: $0, relatedBy: .equal,
                                toItem: superview, attribute: $0, multiplier: 1.0, constant: 0.0) }
      .forEach { superview.addConstraint($0) }
  }
}
