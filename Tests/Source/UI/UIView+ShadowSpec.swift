//
//  VectorableOperationsSpec.swift
//  Tests
//
//  Created by Dmitry Duleba on 3/23/19.
//

import XCTest
import Nimble
@testable import Alidade

//swiftlint:disable identifier_name
class UIViewShadowSpec: XCTestCase {
  func testShadow() {
    let view = UIView()
    view.frame = .init(x: 0, y: 0, width: 50, height: 50)
    view.shadow = .sketch(bounds: view.bounds)
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [view] _ in
      view.frame = .init(x: 0, y: 0, width: 150, height: 150)
    }
  }
}
