//
//  UIViewController.swift
//  Utility
//
//  Created by Dmitry Duleba on 11/15/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

protocol ViewControllerContainer {

  func add(_ childViewController: UIViewController?, to containerView: UIView)
  func remove(_ childViewController: UIViewController?)
}

extension ViewControllerContainer where Self: UIViewController {

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
    childViewController.view.snp.remakeConstraints {
      $0.edges.equalToSuperview()
    }
    childViewController.didMove(toParentViewController: self)
  }
}
