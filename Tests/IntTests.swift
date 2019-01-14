//
//  IntTests.swift
//  Tests
//
//  Created by AP Dzmitry Duleba on 1/14/19.
//  Copyright © 2019 NetcoSports. All rights reserved.
//

import XCTest
import Nimble
import Alidade

class IntTests: XCTestCase {

  func testCycleClamp() {
    expect((-15).cycleClamp(0, 6)) == 6
    expect((-14).cycleClamp(0, 6)) == 0
    expect((-13).cycleClamp(0, 6)) == 1
    expect((-12).cycleClamp(0, 6)) == 2
    expect((-11).cycleClamp(0, 6)) == 3
    expect((-10).cycleClamp(0, 6)) == 4
    expect((-9).cycleClamp(0, 6)) == 5
    expect((-8).cycleClamp(0, 6)) == 6
    expect((-7).cycleClamp(0, 6)) == 0
    expect((-6).cycleClamp(0, 6)) == 1
    expect((-5).cycleClamp(0, 6)) == 2
    expect((-4).cycleClamp(0, 6)) == 3
    expect((-3).cycleClamp(0, 6)) == 4
    expect((-2).cycleClamp(0, 6)) == 5
    expect((-1).cycleClamp(0, 6)) == 6
    expect((0).cycleClamp(0, 6)) == 0
    expect((1).cycleClamp(0, 6)) == 1
    expect((2).cycleClamp(0, 6)) == 2
    expect((3).cycleClamp(0, 6)) == 3
    expect((4).cycleClamp(0, 6)) == 4
    expect((5).cycleClamp(0, 6)) == 5
    expect((6).cycleClamp(0, 6)) == 6
    expect((7).cycleClamp(0, 6)) == 0
    expect((8).cycleClamp(0, 6)) == 1
    expect((9).cycleClamp(0, 6)) == 2
    expect((10).cycleClamp(0, 6)) == 3
    expect((11).cycleClamp(0, 6)) == 4
    expect((12).cycleClamp(0, 6)) == 5
    expect((13).cycleClamp(0, 6)) == 6
    expect((14).cycleClamp(0, 6)) == 0
    expect((15).cycleClamp(0, 6)) == 1
  }

}
