//
//  Created by Dmitry Duleba on 4/8/19.
//

import UIKit

public extension CALayer {

  enum BlendMode: CaseIterable {
    case normal
    case darken
    case multiply
    case colorBurn

    case lighten
    case screen
    case colorDodge

    case overlay
    case softLight
    case hardLight
    case difference
    case exclusion

    // swiftlint:disable:next cyclomatic_complexity
    fileprivate init?(value: Any?) {
      guard let stringValue = value as? String else { return nil }

      switch stringValue {
      case "normalBlendMode": self = .normal
      case "darkenBlendMode": self = .darken
      case "multiplyBlendMode": self = .multiply
      case "colorBurnBlendMode": self = .colorBurn
      case "lightenBlendMode": self = .lighten
      case "screenBlendMode": self = .screen
      case "colorDodgeBlendMode": self = .colorDodge
      case "overlayBlendMode": self = .overlay
      case "softLightBlendMode": self = .softLight
      case "hardLightBlendMode": self = .hardLight
      case "differenceBlendMode": self = .difference
      case "exclusionBlendMode": self = .exclusion
      default: return nil
      }

    }

    fileprivate var value: String {
      switch self {
      case .normal: return "normalBlendMode"
      case .darken: return "darkenBlendMode"
      case .multiply: return "multiplyBlendMode"
      case .colorBurn: return "colorBurnBlendMode"
      case .lighten: return "lightenBlendMode"
      case .screen: return "screenBlendMode"
      case .colorDodge: return "colorDodgeBlendMode"
      case .overlay: return "overlayBlendMode"
      case .softLight: return "softLightBlendMode"
      case .hardLight: return "hardLightBlendMode"
      case .difference: return "differenceBlendMode"
      case .exclusion: return "exclusionBlendMode"
      }
    }

  }

  var blendMode: BlendMode? {
    get { return BlendMode(value: compositingFilter) }
    set { compositingFilter = newValue?.value }
  }

}
