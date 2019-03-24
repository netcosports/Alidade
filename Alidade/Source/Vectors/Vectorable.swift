//
//  Vectorable.swift
//  Alidade
//
//  Created by Dmitry Duleba on 1/6/18.
//

import struct UIKit.CGFloat
import struct UIKit.CGPoint
import struct UIKit.CGSize
import struct UIKit.CGVector
import struct UIKit.UIOffset
import struct UIKit.CGRect
import struct UIKit.UIEdgeInsets

extension CGFloat: SIMDScalar {

  public typealias SIMDMaskScalar = Int

  public typealias SIMD2Storage = SIMD2<CGFloat>

  public typealias SIMD4Storage = SIMD4<CGFloat>

  public typealias SIMD8Storage = SIMD8<CGFloat>

  public typealias SIMD16Storage = SIMD16<CGFloat>

  public typealias SIMD32Storage = SIMD32<CGFloat>

  public typealias SIMD64Storage = SIMD64<CGFloat>

}

// MARK: - CGPoint

extension CGPoint: SIMD {

  public typealias Scalar = CGFloat

  public typealias MaskStorage = SIMD2<Scalar.SIMDMaskScalar>

  public var scalarCount: Int { return 2 }

  public subscript(index: Int) -> CGFloat {
    get {
      if index == 0 { return x } else { return y }
    }
    set {
      if index == 0 { x = newValue } else { y = newValue }
    }
  }

}

// MARK: - CGSize

extension CGSize: SIMD {

  public typealias Scalar = CGFloat

  public typealias MaskStorage = SIMD2<Scalar.SIMDMaskScalar>

  public var scalarCount: Int { return 2 }

  public subscript(index: Int) -> CGFloat {
    get {
      if index == 0 { return width } else { return height }
    }
    set {
      if index == 0 { width = newValue } else { height = newValue }
    }
  }

}

// MARK: - CGVector

extension CGVector: SIMD {

  public typealias Scalar = CGFloat

  public typealias MaskStorage = SIMD2<Scalar.SIMDMaskScalar>

  public var scalarCount: Int { return 2 }

  public subscript(index: Int) -> CGFloat {
    get {
      if index == 0 { return dx } else { return dy }
    }
    set {
      if index == 0 { dx = newValue } else { dy = newValue }
    }
  }

}

// MARK: - UIOffset

extension UIOffset: SIMD {

  public typealias Scalar = CGFloat

  public typealias MaskStorage = SIMD2<Scalar.SIMDMaskScalar>

  public var scalarCount: Int { return 2 }

  public subscript(index: Int) -> CGFloat {
    get {
      if index == 0 { return horizontal } else { return vertical }
    }
    set {
      if index == 0 { horizontal = newValue } else { vertical = newValue }
    }
  }

}

// MARK: - CGRect

extension CGRect: SIMD {

  public typealias Scalar = CGFloat

  public typealias MaskStorage = SIMD4<Scalar.SIMDMaskScalar>

  public var scalarCount: Int { return 4 }

  public subscript(index: Int) -> CGFloat {
    get {
      switch index {
      case 0: return origin.x
      case 1: return origin.y
      case 2: return size.width
      default: return size.height
      }
    }
    set {
      switch index {
      case 0: origin.x = newValue
      case 1: origin.y = newValue
      case 2: size.width = newValue
      default: size.height = newValue
      }
    }
  }

}

// MARK: - UIEdgeInsets

extension UIEdgeInsets: SIMD {

  public typealias Scalar = CGFloat

  public typealias MaskStorage = SIMD4<Scalar.SIMDMaskScalar>

  public var scalarCount: Int { return 4 }

  public subscript(index: Int) -> CGFloat {
    get {
      switch index {
      case 0: return top
      case 1: return left
      case 2: return bottom
      default: return right
      }
    }
    set {
      switch index {
      case 0: top = newValue
      case 1: left = newValue
      case 2: bottom = newValue
      default: right = newValue
      }
    }
  }

}
