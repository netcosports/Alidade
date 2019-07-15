//
//  IntExtensionSpec.swift
//  Tests
//
//  Created by AP Dzmitry Duleba on 1/14/19.
//

import XCTest
import Nimble
@testable import Alidade

class IntExtensionTests: XCTestCase {

  func testIsEven() {
    expect((-2).isEven).to(equal(true))
    expect((-1).isEven).to(equal(false))
    expect(0.isEven).to(equal(true))
    expect(1.isEven).to(equal(false))
    expect(2.isEven).to(equal(true))
  }

  func testCG() {
    expect(1.cg).to(equal(CGFloat(1.0)))
  }

  func testCycleClamp() {
    expect((-5).cycleClamp(0, 3)) == 3
    expect((-4).cycleClamp(0, 3)) == 0
    expect((-3).cycleClamp(0, 3)) == 1
    expect((-2).cycleClamp(0, 3)) == 2
    expect((-1).cycleClamp(0, 3)) == 3

    expect((0).cycleClamp(0, 3)) == 0

    expect((1).cycleClamp(0, 3)) == 1
    expect((2).cycleClamp(0, 3)) == 2
    expect((3).cycleClamp(0, 3)) == 3
    expect((4).cycleClamp(0, 3)) == 0
    expect((5).cycleClamp(0, 3)) == 1
  }

  func testAbs() {
    expect(2.abs).to(equal(2))
    expect((-1).abs).to(equal(1))
  }

  func testFormatted() {
    expect(1.formatted("")).to(equal("1"))
    expect(1.formatted("3")).to(equal("  1"))
    expect(1.formatted("03")).to(equal("001"))
  }

}
