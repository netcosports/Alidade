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
    $0.colors = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
    $0.locations = (0..<7).map { CGFloat($0) / 6.0 }
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
//    super.viewDidLayoutSubviews()
//    let top = view.safeAreaLayoutGuide.layoutFrame.minY
//    lineView.frame = CGRect(origin: CGPoint([120.ui, top]),
//                            size: CGSize([400.ui, 1.0]))
//    gradientView.frame = CGRect(origin: CGPoint([50.ui, top + 20.ui]),
//                                size: CGSize([540.ui, 10.ui]))
  }
}
