//
//  VectorableRepresentationSpec.swift
//  Tests
//
//  Created by Dmitry Duleba on 3/23/19.
//

import XCTest
import Nimble

import Alidade

//swiftlint:disable identifier_name
class VectorableRepresentationSpec: XCTestCase {

  let point = CGPoint(x: 3, y: 4)
  let size = CGSize(width: 3, height: 4)
  let vector = CGVector(dx: 3, dy: 4)
  let offset = UIOffset(horizontal: 3, vertical: 4)

  func testCGSize() {
    expect(self.point.sizeValue).to(equal(size))
    expect(self.size.sizeValue).to(equal(size))
    expect(self.vector.sizeValue).to(equal(size))
    expect(self.offset.sizeValue).to(equal(size))
  }

  func testCGPoint() {
    expect(self.point.pointValue).to(equal(point))
    expect(self.size.pointValue).to(equal(point))
    expect(self.vector.pointValue).to(equal(point))
    expect(self.offset.pointValue).to(equal(point))
  }

  func testCGVector() {
    expect(self.point.vectorValue).to(equal(vector))
    expect(self.size.vectorValue).to(equal(vector))
    expect(self.vector.vectorValue).to(equal(vector))
    expect(self.offset.vectorValue).to(equal(vector))
  }

  func testUIOffset() {
    expect(self.point.offsetValue).to(equal(offset))
    expect(self.size.offsetValue).to(equal(offset))
    expect(self.vector.offsetValue).to(equal(offset))
    expect(self.offset.offsetValue).to(equal(offset))
  }

}
