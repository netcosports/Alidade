import Foundation
import UIKit

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
    let hsl = HSL(.random, .random, luminance)
    return hsl.color()
  }

  var luminance: CGFloat {
    let hsl = hslValue()
    return hsl.luminance
  }

  func withLuminance(_ luminance: CGFloat) -> UIColor {
    let hsl = hslValue()
    let newHSL = HSL(hsl.hue, hsl.saturation, luminance, hsl.alpha)
    return newHSL.color()
  }

  var isLight: Bool { return luminance >= Lightness.threashold }
}

// MARK: - RGBA

public extension UIColor {

  public struct RGB: Equatable, CustomDebugStringConvertible {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let alpha: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: RGB, r: RGB) -> Bool {
      return l.red == r.red && l.green == r.green && l.blue == r.blue && l.alpha == r.alpha
    }

    public init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
      red = r.normalized
      green = g.normalized
      blue = b.normalized
      alpha = a.normalized
    }
    // swiftlint:enable identifier_name

    public var debugDescription: String {
      return "r: %.2\(red)), g: %.2\(green), b: %.2\(blue), a: %.2\(alpha)"
    }

    public func hslValue() -> HSL {
      let _max = max(red, green, blue)
      let _min = min(red, green, blue)
      let l = (_max + _min) * 0.5
      guard _max != _min else {
        return HSL(0.0, 0.0, l)
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
      return HSL(h, s, l, alpha)
    }

    public func hsbValue() -> HSB {
      let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
      var h, s, b, a: CGFloat
      (h, s, b, a) = (0.0, 0.0, 0.0, 0.0)
      color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
      let hsb = HSB(h, s, b, a)
      return hsb
    }

    public func color() -> UIColor {
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  public func rgbValue() -> RGB {
    var r, g, b, a: CGFloat
    (r, g, b, a) = (0.0, 0.0, 0.0, 0.0)
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return RGB(r, g, b, a)
  }
}

// MARK: - HSL

public extension UIColor {

  public struct HSL: Equatable, CustomDebugStringConvertible {
    public let hue: CGFloat
    public let saturation: CGFloat
    public let luminance: CGFloat
    public let alpha: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: HSL, r: HSL) -> Bool {
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
        return RGB(1.0, 1.0, 1.0).color()
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
      let rgb = RGB(r, g, b)
      return rgb.color()
    }
    // swiftlint:enable identifier_name
  }
}

// MARK: - HSB

public extension UIColor {

  public struct HSB: Equatable, CustomDebugStringConvertible {
    public let hue: CGFloat
    public let saturation: CGFloat
    public let brightness: CGFloat
    public let alpha: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: HSB, r: HSB) -> Bool {
      return l.hue == r.hue && l.saturation == r.saturation && l.brightness == r.brightness && l.alpha == r.alpha
    }

    public init(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
      hue = h.normalized
      saturation = s.normalized
      brightness = b.normalized
      alpha = a.normalized
    }
    // swiftlint:enable identifier_name

    public func color() -> UIColor {
      let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
      return color
    }

    public var debugDescription: String {
      return "h: %.2\(hue), s: %.2\(saturation), l: %.2\(brightness), a: %.2\(alpha)"
    }
  }

  public func hsbValue() -> HSB {
    return rgbValue().hsbValue()
  }

  public func hslValue() -> HSL {
    return rgbValue().hslValue()
  }
}
