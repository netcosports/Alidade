import UIKit

private var updater = Updater()

// MARK: - Updater

private class Updater: NSObject {

  var updateables     = NSMutableSet()
  var didSetToUpdate  = false

  func update() {
    let candidates = updateables.allObjects
    updateables.removeAllObjects()
    candidates.forEach {
      guard !updateables.contains($0) else { return }
      guard let updatable = $0 as? Updateable else { return }
      updatable.update()
    }
    didSetToUpdate = false
  }

  func add(_ updateable: Updateable) {
    updateables.add(updateable)
    guard !didSetToUpdate else { return }

    DispatchQueue.main.async {
      self.update()
    }
  }
}

// MARK: - Updateable

public protocol Updateable: class {

  func update()
  func setNeedsUpdate()
  func updateIfNeeded()
}

public extension Updateable {

  public func setNeedsUpdate() {
    updater.add(self)
  }

  public func updateIfNeeded() {
    update()
  }
}
