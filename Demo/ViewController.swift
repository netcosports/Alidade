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

  enum Const {
    static var value: UInt8 = 0
  }

  var value: CGFloat? {
    return associated.value(for: &Const.value)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    Demo().run()
  }
}
