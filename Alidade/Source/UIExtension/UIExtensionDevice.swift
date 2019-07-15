//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

public extension UI {

  enum Device { }
}

public extension UI.Device {

  static func value<T>(_ phone: T, _ pad: T) -> T {
    return UIDevice.current.userInterfaceIdiom == .pad ? pad : phone
  }
}

public extension UI.Device {

  static let isIPhoneX: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone &&
        UIScreen.main.nativeBounds.height == 2436
  }()

  static let isIPhoneXR: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone &&
      UIScreen.main.nativeBounds.height == 1792
  }()

  static let isIPhoneXS: Bool = {
    return isIPhoneX
  }()

  static let isIPhoneXSMax: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone &&
      UIScreen.main.nativeBounds.height == 2688
  }()

  static let isIPhoneXSeries: Bool = {
    return isIPhoneX || isIPhoneXR || isIPhoneXS || isIPhoneXSMax
  }()
}

public extension UI.Device {

  enum System {

    case iOS9
    case iOS10
    case iOS11
    case iOS12
    case iOS13

    public static let current: System = {
      if #available(iOS 13, *) {
        return System.iOS13
      }
      if #available(iOS 12, *) {
        return System.iOS12
      }
      if #available(iOS 11, *) {
        return System.iOS11
      }
      if #available(iOS 10, *) {
        return System.iOS10
      }
      return System.iOS9
    }()
  }
}
