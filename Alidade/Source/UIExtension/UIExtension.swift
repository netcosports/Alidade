//
//  Created by Dmitry Duleba on 10/24/17.
//

import UIKit
import Foundation
#if SWIFT_PACKAGE
	import AlidadeCore
#endif

//swiftlint:disable line_length type_name identifier_name

// MARK: - UI

public enum UI {

  public enum Intent: Hashable {
    case general
    case module(Module)
  }

  public typealias Widths = [UIUserInterfaceIdiom: CGFloat]
  private typealias IntentWidths = [Intent: Widths]

  private static var intentBaseWidths = IntentWidths()
  private static var intentScaleFactor = [Intent: CGFloat]()

  public static func baseWidths(for intent: Intent = .general) -> Widths {
    return intentBaseWidths[intent] ?? [:]
  }

  public static func setBaseWidths(_ widths: Widths, for intent: Intent = .general) {
    intentBaseWidths[intent] = widths
    intentScaleFactor[intent] = calculateScale(for: intent)
  }

  public static func scaleFactor(for intent: Intent = .general) -> CGFloat {
    if let scale = intentScaleFactor[intent] {
      return scale
    }

    let scale = calculateScale(for: intent)
    intentScaleFactor[intent] = scale
    return scale
  }

}

// MARK: - Private.UI

private extension UI {

  static func calculateScale(for intent: Intent) -> CGFloat {
    let size = UIScreen.main.bounds.size
    let width = min(size.width, size.height)
    let idiom = UIDevice.current.userInterfaceIdiom
    let result: CGFloat
    let baseWidth: CGFloat
    let intentWidths = intentBaseWidths[intent] ?? [:]
    switch idiom {
    case .pad: baseWidth = intentWidths[idiom] ?? 1536.0
    case .phone: baseWidth = intentWidths[idiom] ?? 640.0
    default: baseWidth = width
    }
    result = width / baseWidth
    return result
  }

}
