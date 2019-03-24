//
//  VectorableOperationsSpec.swift
//  Tests
//
//  Created by Dmitry Duleba on 3/23/19.
//

import XCTest
import Nimble

//swiftlint:disable identifier_name
class VectorableOperationsSpec: XCTestCase {

  final class PointsGenerator {

    func randomFoundationPoint() -> CGPoint {
      return CGPoint(x: CGFloat.random(in: -1000...1000), y: CGFloat.random(in: -1000...1000))
    }

    func randomSIMDPoint() -> CGPoint {
      return CGPoint.random(in: -1000...1000)
    }

  }

  func testRandom() {
    let value = PointsGenerator().randomSIMDPoint()
    expect(value.x).to(beGreaterThanOrEqualTo(-1000))
    expect(value.y).to(beGreaterThanOrEqualTo(-1000))
    expect(value.x).to(beLessThanOrEqualTo(1000))
    expect(value.y).to(beLessThanOrEqualTo(1000))
  }

  func testPerformanceFoundationRandomGenerator() {
    let generator = PointsGenerator()
    measure {
      for _ in 0...1_000 {
        _ = generator.randomFoundationPoint()
      }
    }
  }

  func testPerformanceSIMDRandomGenerator() {
    let generator = PointsGenerator()
    measure {
      for _ in 0...1_000 {
        _ = generator.randomSIMDPoint()
      }
    }
  }

  func testAddPerformance() {
    let generator = PointsGenerator()
    measure {
      for _ in 0...1000 {
        let p0 = generator.randomSIMDPoint()
        let p1 = generator.randomSIMDPoint()
        _ = p0 + p1
      }
    }
  }

}
