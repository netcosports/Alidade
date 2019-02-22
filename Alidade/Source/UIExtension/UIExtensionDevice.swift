//
//  UIExtensionDevice.swift
//  Utility
//
//  Created by Dmitry Duleba on 10/24/17.
//

import Foundation
import UIKit

public extension UI {

  public enum Device { }
}

public extension UI.Device {

  public static func value<T>(_ phone: T, _ pad: T) -> T {
    return UIDevice.current.userInterfaceIdiom == .pad ? pad : phone
  }
}

public extension UI.Device {

  public static let isIPhoneX: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone &&
        UIScreen.main.nativeBounds.height == 2436
  }()
  
  public static let isIPhoneXR: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone &&
      UIScreen.main.nativeBounds.height == 1792
  }()

  public static let isIPhoneXS: Bool = {
    return isIPhoneX
  }()

  public static let isIPhoneXSMax: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone &&
      UIScreen.main.nativeBounds.height == 2688
  }()
  
  public static let isIPhoneXSeries: Bool = {
    return isIPhoneX || isIPhoneXR || isIPhoneXS || isIPhoneXSMax
  }()
}

public extension UI.Device {

  public enum System {

    case iOS9
    case iOS10
    case iOS11

    public static let current: System = {
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
