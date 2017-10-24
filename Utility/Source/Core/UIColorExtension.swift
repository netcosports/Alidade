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
    let newHSL = HSL(hsl.hue, hsl.saturation, luminance)
    return newHSL.color()
  }

  var isLight: Bool { return luminance >= Lightness.threashold }
}

// MARK: - RGB

public extension UIColor {

  public struct RGB: Equatable, CustomDebugStringConvertible {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: RGB, r: RGB) -> Bool {
      return l.red == r.red && l.green == r.green && l.blue == r.blue
    }

    public init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
      red = r.normalized
      green = g.normalized
      blue = b.normalized
    }
    // swiftlint:enable identifier_name

    public var debugDescription: String {
      return "r: \(red.formatted(".2")), g: \(green.formatted(".2")), b: \(blue.formatted(".2"))"
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
      return HSL(h, s, l)
    }

    public func hsbValue() -> HSB {
      let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
      var h, s, b: CGFloat
      (h, s, b) = (0.0, 0.0, 0.0)
      color.getHue(&h, saturation: &s, brightness: &b, alpha: nil)
      let hsb = HSB(h, s, b)
      return hsb
    }

    public func color() -> UIColor {
      return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
  }

  public func rgbValue() -> RGB {
    var r, g, b: CGFloat
    (r, g, b) = (0.0, 0.0, 0.0)
    getRed(&r, green: &g, blue: &b, alpha: nil)
    return RGB(r, g, b)
  }
}

// MARK: - HSL

public extension UIColor {

  public struct HSL: Equatable, CustomDebugStringConvertible {
    public let hue: CGFloat
    public let saturation: CGFloat
    public let luminance: CGFloat

    // swiftlint:disable identifier_name
    static public func == (l: HSL, r: HSL) -> Bool {
      return l.hue == r.hue && l.saturation == r.saturation && l.luminance == r.luminance
    }

    public init(_ h: CGFloat, _ s: CGFloat, _ l: CGFloat) {
      hue = h.normalized
      saturation = s.normalized
      luminance = l.normalized
    }
    // swiftlint:enable identifier_name

    public var debugDescription: String {
      return "h: \(hue.formatted(".2")), s: \(saturation.formatted(".2")), l: \(luminance.formatted(".2"))"
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

    // swiftlint:disable identifier_name
    static public func == (l: HSB, r: HSB) -> Bool {
      return l.hue == r.hue && l.saturation == r.saturation && l.brightness == r.brightness
    }

    public init(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat) {
      hue = h.normalized
      saturation = s.normalized
      brightness = b.normalized
    }
    // swiftlint:enable identifier_name

    public func color() -> UIColor {
      let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
      return color
    }

    public var debugDescription: String {
      return "h: \(hue.formatted(".2")), s: \(saturation.formatted(".2")), l: \(brightness.formatted(".2"))"
    }
  }

  public func hsbValue() -> HSB {
    return rgbValue().hsbValue()
  }

  public func hslValue() -> HSL {
    return rgbValue().hslValue()
  }
}
