//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

//swiftlint:disable identifier_name
public extension UIColor {

  enum Lightness {
    case dark
    case light

    fileprivate static let threashold: CGFloat = 0.65
  }

  static var random: UIColor {
    let r = CGFloat.random
    let g = CGFloat.random
    let b = CGFloat.random
    let result = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    return result
  }

  static func random(_ lightness: Lightness) -> UIColor {
    let range: (location: CGFloat, length: CGFloat) = lightness == .light
      ? (Lightness.threashold, 1.0 - Lightness.threashold)
      : (0.0, Lightness.threashold)
    let luminance = range.location + range.length * .random
    let hsl = HSLA(.random, .random, luminance)
    return hsl.color()
  }

  var luminance: CGFloat {
    let hsl = hslaValue()
    return hsl.luminance
  }

  func withLuminance(_ luminance: CGFloat) -> UIColor {
    let hsl = hslaValue()
    let newHSL = HSLA(hsl.hue, hsl.saturation, luminance, hsl.alpha)
    return newHSL.color()
  }

  var isLight: Bool { return luminance >= Lightness.threashold }
}

// MARK: - RGBA

public extension UIColor {

  struct RGBA: Equatable, CustomDebugStringConvertible {
    public var red: CGFloat
    public var green: CGFloat
    public var blue: CGFloat
    public var alpha: CGFloat

    static public func == (l: RGBA, r: RGBA) -> Bool {
      return l.red == r.red && l.green == r.green && l.blue == r.blue && l.alpha == r.alpha
    }

    public init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
      red = r.normalized
      green = g.normalized
      blue = b.normalized
      alpha = a.normalized
    }

    public var debugDescription: String {
      //swiftlint:disable:next line_length
      return "r: \(String(format: "%.2f", red)), g: \(String(format: "%.2f", green)), b: \(String(format: "%.2f", blue)), a: \(String(format: "%.2f", alpha))"
    }

    public func hslaValue() -> HSLA {
      let _max = max(red, green, blue)
      let _min = min(red, green, blue)
      let l = (_max + _min) * 0.5
      guard _max != _min else {
        return HSLA(0.0, 0.0, l)
      }

      let d = _max - _min
      let s = l > 0.5 ? d / (2.0 - _max - _min) : d / (_max + _min)
      var h = l
      switch _max {
      case red: h = (green - blue) / d + (green < blue ? 6.0 : 0.0)
      case green: h = (blue - red) / d + 2.0
      case blue: h = (red - green) / d + 4.0
      default: break
      }
      h /= 6.0
      return HSLA(h, s, l, alpha)
    }

    public func hsbaValue() -> HSBA {
      let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
      var h, s, b, a: CGFloat
      (h, s, b, a) = (0.0, 0.0, 0.0, 0.0)
      color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
      let hsb = HSBA(h, s, b, a)
      return hsb
    }

    public func color() -> UIColor {
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  func rgbaValue() -> RGBA {
    var r, g, b, a: CGFloat
    (r, g, b, a) = (0.0, 0.0, 0.0, 0.0)
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return RGBA(r, g, b, a)
  }
}

// MARK: - HSLA

public extension UIColor {

  struct HSLA: Equatable, CustomDebugStringConvertible {
    public var hue: CGFloat
    public var saturation: CGFloat
    public var luminance: CGFloat
    public var alpha: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: HSLA, r: HSLA) -> Bool {
      return l.hue == r.hue && l.saturation == r.saturation && l.luminance == r.luminance && l.alpha == r.alpha
    }

    public init(_ h: CGFloat, _ s: CGFloat, _ l: CGFloat, _ a: CGFloat = 1.0) {
      hue = h.normalized
      saturation = s.normalized
      luminance = l.normalized
      alpha = a.normalized
    }
    // swiftlint:enable identifier_name

    public var debugDescription: String {
      return "h: %.2\(hue), s: %.2\(saturation), l: %.2\(luminance), a: %.2\(alpha)"
    }

    public func color() -> UIColor {
      guard saturation != 0.0 else {
        return RGBA(1.0, 1.0, 1.0).color()
      }

      // swiftlint:disable identifier_name
      func hue2rgb(_ p: CGFloat, _ q: CGFloat, _ t: CGFloat) -> CGFloat {
        let _t: CGFloat
        switch t {
        case (...0): _t = t + 1.0
        case (1...): _t = t - 1.0
        default: _t = t
        }

        switch _t {
        case ...(1.0 / 6.0): return p + (q - p) * 6.0 * t
        case ...(1.0 / 2.0): return q
        case ...(2.0 / 3.0): return p + (q - p) * (2.0 / 3.0 - t) * 6.0
        default: return p
        }
      }

      let q = luminance < 0.5 ? luminance * (1.0 + saturation) : luminance + saturation - luminance * saturation
      let p = 2.0 * luminance - q

      let r = hue2rgb(p, q, hue + 1.0 / 3.0)
      let g = hue2rgb(p, q, hue)
      let b = hue2rgb(p, q, hue - 1.0 / 3.0)
      let rgba = RGBA(r, g, b, alpha)
      return rgba.color()
    }
    // swiftlint:enable identifier_name
  }
}

// MARK: - HSBA

public extension UIColor {

  struct HSBA: Equatable, CustomDebugStringConvertible {
    public var hue: CGFloat
    public var saturation: CGFloat
    public var brightness: CGFloat
    public var alpha: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: HSBA, r: HSBA) -> Bool {
      return l.hue == r.hue && l.saturation == r.saturation && l.brightness == r.brightness && l.alpha == r.alpha
    }

    public init(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
      hue = h.normalized
      saturation = s.normalized
      brightness = b.normalized
      alpha = a.normalized
    }
    // swiftlint:enable identifier_name

    func color() -> UIColor {
      let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
      return color
    }

    public var debugDescription: String {
      return "h: %.2\(hue), s: %.2\(saturation), l: %.2\(brightness), a: %.2\(alpha)"
    }
  }

  func hsbaValue() -> HSBA {
    return rgbaValue().hsbaValue()
  }

  func hslaValue() -> HSLA {
    return rgbaValue().hslaValue()
  }
}
//swiftlint:enable identifier_name
