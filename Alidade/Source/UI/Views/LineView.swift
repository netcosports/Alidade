import UIKit
import CoreGraphics

// MARK: - LineView

public class LineView: UIView {

  public var startPosition = CGPoint(x: 0.0, y: 0.5) { didSet { setNeedsDisplay() } }
  public var endPosition = CGPoint(x: 1.0, y: 0.5) { didSet { setNeedsDisplay() } }
  public var lineWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
  public var lineCap: CGLineCap = .butt { didSet { setNeedsDisplay() } }
  public var lineJoin: CGLineJoin = .miter { didSet { setNeedsDisplay() } }
  public var pattern: [CGFloat] = [] { didSet { setNeedsDisplay() } }
  public var color: UIColor = .black { didSet { setNeedsDisplay() } }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func draw(_ rect: CGRect) {
    color.setStroke()
    path(in: rect).stroke()
  }

}

// MARK: - Private

private extension LineView {

  func setup() {
    backgroundColor = .clear
  }

  func path(in rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: convert(relativePoint: startPosition, to: rect))
    path.addLine(to: convert(relativePoint: endPosition, to: rect))
    path.lineWidth = lineWidth
    path.lineCapStyle = lineCap
    path.lineJoinStyle = lineJoin
    path.setLineDash(pattern, count: pattern.count, phase: 0.0)
    return path
  }

  func convert(relativePoint: CGPoint, to bounds: CGRect) -> CGPoint {
    let x = relativePoint.x * bounds.size.width
    let y = relativePoint.y * bounds.size.height
    let result = CGPoint(x: x, y: y)
    return result
  }

}
