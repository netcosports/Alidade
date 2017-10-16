import UIKit

// MARK: - LineView.ViewModel

public extension LineView {

  public struct ViewModel {
    public let color: UIColor
    public let start: CGPoint
    public let end: CGPoint
    public let width: CGFloat
    public let pattern: [CGFloat]

    public init(color: UIColor? = nil, start: CGPoint? = nil, end: CGPoint? = nil,
                width: CGFloat? = nil, pattern: [CGFloat]? = nil) {
      self.color = color ?? .black
      self.start = start ?? CGPoint(x: 0.0, y: 0.0)
      self.end = end ?? CGPoint(x: 1.0, y: 0.0)
      self.width = width ?? 1.0
      self.pattern = pattern ?? [10.0, 10.0]
    }
  }
}

// MARK: - LineView

public class LineView: UIView {

  public var data = ViewModel() { didSet { setNeedsDisplay() } }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func draw(_ rect: CGRect) {
    let path = UIBezierPath()
    path.move(to: convert(relativePoint: data.start, to: rect))
    path.addLine(to: convert(relativePoint: data.end, to: rect))
    path.close()
    path.lineWidth = data.width
    path.setLineDash(data.pattern, count: data.pattern.count, phase: 0.0)
    data.color.setStroke()
    path.stroke()
  }
}

// MARK: - Private

fileprivate extension LineView {

  func setup() {
    backgroundColor = .clear
  }

  func convert(relativePoint: CGPoint, to bounds: CGRect) -> CGPoint {
    let x = relativePoint.x * bounds.size.width
    let y = relativePoint.y * bounds.size.height
    let result = CGPoint(x: x, y: y)
    return result
  }
}
