import Foundation

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

    DispatchQueue.main.async { [weak self] in
      self?.update()
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

  func setNeedsUpdate() {
    updater.add(self)
  }

  func updateIfNeeded() {
    update()
  }
}
