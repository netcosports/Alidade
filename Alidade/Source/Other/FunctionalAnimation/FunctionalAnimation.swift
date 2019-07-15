//
//  Created by Dmitry Duleba on 3/13/19.
//

import Foundation
import UIKit

public class FunctionalAnimation: Hashable {

  let identifier: Int
  let duration: TimeInterval
  let timing: Timing

  fileprivate(set) var progress: CGFloat
  var value: CGFloat { return timing.value(for: progress) }

  fileprivate let block: (FunctionalAnimation) -> Void

  // MARK: Init

  init(duration: TimeInterval = 0.3,
       timing: Timing = Timing(name: .linear),
       _ block: @escaping (FunctionalAnimation) -> Void) {
    progress = 0.0
    identifier = UUID().uuidString.hashValue
    self.timing = timing
    self.duration = duration
    self.block = block
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
    hasher.combine(duration)
  }

  public static func == (lhs: FunctionalAnimation, rhs: FunctionalAnimation) -> Bool {
    return lhs.identifier == rhs.identifier
  }

}

// MARK: - Animator

public extension FunctionalAnimation {

  class Animator {

    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(fire))
    private var animations = [(TimeInterval, FunctionalAnimation)]()

    private let lock = NSRecursiveLock()

    init() {
      if #available(iOS 10.0, *) {
        displayLink.preferredFramesPerSecond = 60
      }
    }

    func add(_ animation: FunctionalAnimation) {
      lock.lock()
      defer { lock.unlock() }
      guard !animations.map({ $1 }).contains(animation) else { return }

      animations.append((startTime(for: animation), animation))
      if animations.count == 1 {
        displayLink.add(to: .current, forMode: .common)
      }
    }

  }
}

// MARK: - Animator.Private

private extension FunctionalAnimation.Animator {

  @objc func fire(_ link: CADisplayLink) {
    animations.forEach { start, animation in
      guard animation.duration > 0 else {
        perform(animation, with: 1.0)
        return
      }

      let elapsed = link.timestamp - start
      let progress = (elapsed / animation.duration).clamp(0.0, 1.0)
      perform(animation, with: CGFloat(progress))
    }
    cleanup()
  }

  func startTime(for animation: FunctionalAnimation) -> CFTimeInterval {
    return CACurrentMediaTime()
  }

  func perform(_ animation: FunctionalAnimation, with progress: CGFloat) {
    animation.progress = progress
    animation.block(animation)
  }

  func cleanup() {
    lock.lock()
    defer { lock.unlock() }

    animations.removeAll { $1.progress >= 1.0 }
    if animations.count == 0 {
      displayLink.remove(from: .current, forMode: .common)
    }
  }

}
