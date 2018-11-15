import UIKit

// MARK: - GradientView.Direction

public extension GradientView {

  public struct Direction {

    public static let up = Direction(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.5, y: 0.0))
    public static let down = Direction(start: CGPoint(x: 0.5, y: 0.0), end: CGPoint(x: 0.5, y: 1.0))
    public static let left = Direction(start: CGPoint(x: 1.0, y: 0.5), end: CGPoint(x: 0.0, y: 0.5))
    public static let right = Direction(start: CGPoint(x: 0.0, y: 0.5), end: CGPoint(x: 1.0, y: 0.5))

    public let start: CGPoint
    public let end: CGPoint

    public init(start: CGPoint, end: CGPoint) {
      self.start = start.clampNormal
      self.end = end.clampNormal
    }
  }
  
}

// MARK: - GradientView

public class GradientView: UIView {

  public var colors: [UIColor] = [.white, .black] { didSet { didUpdateColors() } }
  public var locations: [CGFloat] = [0, 1] { didSet { didUpdateColors() } }
  public var direction: Direction = .right { didSet { didUpdateDirection() } }

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
    gradientLayer?.colors = colors.map { $0.cgColor }
    gradientLayer?.locations = locations.map { NSNumber(value: Double($0)) }
    setNeedsDisplay()
  }

  func didUpdateDirection() {
    gradientLayer?.startPoint = direction.start
    gradientLayer?.endPoint = direction.end
    setNeedsDisplay()
  }

}
