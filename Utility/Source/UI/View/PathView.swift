//
//  PathView.swift
//
//  Created by Dmitry Duleba on 3/31/16.
//  Copyright © 2016 NETCOSPORTS. All rights reserved.
//

import UIKit

public class PathView: UIView {

  public var path: CGPath? { didSet { (layer as? CAShapeLayer)?.path = path } }
  public var color: UIColor? { didSet { (layer as? CAShapeLayer)?.fillColor = color?.cgColor } }

  override public class var layerClass: AnyClass {
    return CAShapeLayer.self
  }
}
