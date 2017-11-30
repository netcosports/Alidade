//
//  UIViewController.swift
//  Utility
//
//  Created by Dmitry Duleba on 11/15/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public protocol ViewControllerContainer {

  func add(_ childViewController: UIViewController?, to containerView: UIView)
  func remove(_ childViewController: UIViewController?)
}

public extension ViewControllerContainer where Self: UIViewController {

  func remove(_ childViewController: UIViewController?) {
    guard let childViewController = childViewController else { return }

    childViewController.willMove(toParentViewController: nil)
    childViewController.view.removeFromSuperview()
    childViewController.removeFromParentViewController()
  }

  func add(_ childViewController: UIViewController?, to containerView: UIView) {
    guard let childViewController = childViewController else { return }

    addChildViewController(childViewController)
    containerView.addSubview(childViewController.view)
    childViewController.view.fillSuperview()
    childViewController.didMove(toParentViewController: self)
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
