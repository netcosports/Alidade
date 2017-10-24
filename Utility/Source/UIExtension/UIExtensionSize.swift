//
//  UIExtensionSize.swift
//  Utility
//
//  Created by Dmitry Duleba on 10/24/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation

public extension UI {

  public enum Size {

    public static let statusBar = 20.0 + cornerRadius
    public static let navigationBar = 44.0 + statusBar

    public static let tabBar: CGFloat = {
      switch UIScreen.main.nativeBounds.height {
      case 2436:
        return 83.0
      default:
        return 49.0
      }
    }()

    public static let cornerRadius: CGFloat = {
      switch UIScreen.main.nativeBounds.height {
      case 2436:
        return 24.0
      default:
        return 0.0
      }
    }()
  }
}
