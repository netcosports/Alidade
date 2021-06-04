//
//  Created by Dmitry Duleba on 4/8/19.
//

import UIKit

public extension UIResponder {

  private func recursiveRespondersChain(for responder: UIResponder?) -> [UIResponder] {
    guard let responder = responder else { return [] }

    return [responder] + recursiveRespondersChain(for: responder.next)
  }

  func responders() -> [UIResponder] {
    return recursiveRespondersChain(for: next)
  }

}
