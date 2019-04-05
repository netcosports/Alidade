//
//  VectorableTests.swift
//  Tests
//
//  Created by Dmitry Duleba on 3/22/19.
//

import XCTest
import Nimble
@testable import Alidade

//swiftlint:disable identifier_name

class VectorableInitTests: XCTestCase {

  func testCGPointInitializers() {
    let p0: CGPoint = [3, 4]
    expect(p0.x).to(equal(3))
    expect(p0.y).to(equal(4))

    let p1 = CGPoint(arrayLiteral: 3, 4)
    expect(p1).to(equal(p0))

    let p2 = CGPoint([3, 4])
    expect(p2).to(equal(p1))
  }

}

class VectorableOperatorsTests: XCTestCase {

  func testCGPointBasicOperations() {
    let p0 = CGPoint(x: 3, y: 4)
    let p1 = CGPoint(x: 4, y: 5)
    expect(p0 + p1).to(equal(CGPoint(x: 7, y: 9)))
  }

}
