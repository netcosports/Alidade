//
//  Tests.swift
//  Tests
//
//  Created by Dmitry Duleba on 1/6/18.
//  Copyright © 2018 NetcoSports. All rights reserved.
//

import XCTest
import Utility

let range = 0..<10000

class Tests: XCTestCase {
  
  let intValues = range.map { $0 }
  let floatValues = range.map { CGFloat($0) }
  let points = range.map { CGPoint($0, Int.random()) }
  let sizes = range.map { CGSize(Int.random(), $0) }
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testVectorable() {
    XCTAssert(CGPoint(2, 3) + CGPoint(3, 4) == CGPoint(x: 5, y: 7))
    XCTAssert(-CGPoint(2, 3) == CGPoint(x: -2, y: -3))
    XCTAssert(CGPoint(2, 3) * 10.5 == CGPoint(x: 21, y: 31.5))
    
    XCTAssert(CGPoint(1, 2) == CGPoint(x: 1, y: 2))
    XCTAssert(Double(2) + CGFloat(1) == Double(3))
    XCTAssert(UIEdgeInsets(0, 2, 3, 4) * 2 == UIEdgeInsets(0, 4, 6, 8))
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results
  }
  
  func testPerformanceExample() {
    measure { }
  }
}
