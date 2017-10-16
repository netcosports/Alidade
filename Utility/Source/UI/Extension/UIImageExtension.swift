//
//  UIImageExtension.swift
//
//  Created by Dmitry Duleba on 4/28/17.
//  Copyright © 2017 NetcoSports. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {

  convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }

  func tint(color: UIColor, blendMode: CGBlendMode = .darken) -> UIImage {
    let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    guard let context = UIGraphicsGetCurrentContext(),
      let cgImage = cgImage else { return self }

    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0.0, y: -size.height)
    context.clip(to: drawRect, mask: cgImage)
    color.setFill()
    UIRectFill(drawRect)
    draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
    let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    let result = tintedImage ?? self
    return result
  }
}
