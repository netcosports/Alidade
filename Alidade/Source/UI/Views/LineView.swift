//
//  Created by Dmitry Duleba on 10/24/17.
//

import UIKit

// MARK: - LineView

open class LineView: UIView {

  open var startPosition = CGPoint(x: 0.0, y: 0.5) { didSet { setNeedsDisplay() } }
  open var endPosition = CGPoint(x: 1.0, y: 0.5) { didSet { setNeedsDisplay() } }
  open var lineWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
  open var lineCap: CGLineCap = .butt { didSet { setNeedsDisplay() } }
  open var lineJoin: CGLineJoin = .miter { didSet { setNeedsDisplay() } }
  open var pattern: [CGFloat] = [] { didSet { setNeedsDisplay() } }
  open var color: UIColor = .black { didSet { setNeedsDisplay() } }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    internalSetup()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    internalSetup()
  }

  override open func draw(_ rect: CGRect) {
    color.setStroke()
    path(in: rect).stroke()
  }

  internal func internalSetup() {
    translatesAutoresizingMaskIntoConstraints = false
    setup()
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
