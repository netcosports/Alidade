import UIKit

// MARK: - GradientView.Color

public extension GradientView {

  public struct Color {

    let color: UIColor
    let location: CGFloat

    public init(color: UIColor, location: CGFloat) {
      self.location = location.normalized
      self.color = color
    }

    public init(color: UIColor, location: Double) {
      self.location = CGFloat(location).normalized
      self.color = color
    }
  }
}

// MARK: - GradientView.Direction

public extension GradientView {

  public struct Direction {

    public let start: CGPoint
    public let end: CGPoint

    public init(start: CGPoint, end: CGPoint) {
      self.start = start.clampNormal
      self.end = end.clampNormal
    }
  }
}

public extension GradientView.Direction {

  public static let up = GradientView.Direction(start: CGPoint(x: 0.0, y: 1.0), end: CGPoint(x: 0.0, y: 0.0))
  public static let left = GradientView.Direction(start: CGPoint(x: 1.0, y: 0.0), end: CGPoint(x: 0.0, y: 0.0))
  public static let down = GradientView.Direction(start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0))
  public static let right = GradientView.Direction(start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 1.0, y: 0.0))
}

// MARK: - GradientView

public class GradientView: UIView {

  public var colors = [Color(color: .white, location: 0.0),
                       Color(color: .black, location: 1.0)] { didSet { didUpdateColors() } }
  public var direction = Direction(start: CGPoint(x: 0.0, y: 0.0),
                                   end: CGPoint(x: 1.0, y: 0.0)) { didSet { didUpdateDirection() } }

  private var gradientLayer: CAGradientLayer? { return layer as? CAGradientLayer }

  override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    return nil
  }

  override public class var layerClass: AnyClass {
    return CAGradientLayer.self
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Private

private extension GradientView {

  func setup() {
    backgroundColor = .clear
    didUpdateColors()
    didUpdateDirection()
  }

  func didUpdateColors() {
    gradientLayer?.colors = colors.map { $0.color.cgColor }
    gradientLayer?.locations = colors.map { NSNumber(value: Double($0.location)) }
    setNeedsDisplay()
  }

  func didUpdateDirection() {
    gradientLayer?.startPoint = direction.start
    gradientLayer?.endPoint = direction.end
    setNeedsDisplay()
  }
}
