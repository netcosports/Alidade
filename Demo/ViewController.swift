//
//  ViewController.swift
//  Demo
//
//  Created by Dmitry Duleba on 10/24/17.
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

  let gradientView = GradientView {
    $0.direction = .right
    ($0.layer as? CAGradientLayer)?.with {
      if #available(iOS 12.0, *) {
        $0.type = .conic
      }
      $0.startPoint = CGPoint(0.5, 0.5)
      $0.endPoint = CGPoint(0.5, 0.0)
    }
  }

  override func loadView() {
    super.loadView()
    view.backgroundColor = .lightGray
    view.addSubviews(lineView, gradientView)
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
    gradientView.frame = CGRect(origin: CGPoint(50.ui, top + 20.ui),
                                size: CGSize(540.ui, 200.ui))
  }
}
