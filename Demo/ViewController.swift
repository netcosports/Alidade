//
//  ViewController.swift
//  Demo
//
//  Created by Dmitry Duleba on 10/24/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import UIKit
import Alidade

class ViewController: UIViewController {

  private enum Const {
    static var value: UInt8 = 0
  }

  var value: CGFloat? {
    return associated.value(for: &Const.value)
  }

  let lineView = LineView {
    $0.color = .red
    $0.pattern = [10]
  }

  override func loadView() {
    super.loadView()
    view.addSubviews(lineView)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    Demo().run()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let top = view.safeAreaLayoutGuide.layoutFrame.minY
    lineView.frame = CGRect(origin: CGPoint(120.ui, top),
                            size: CGSize(400.ui, 1.0))
  }
}
