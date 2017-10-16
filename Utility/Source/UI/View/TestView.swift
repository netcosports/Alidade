import Foundation

class TestView: UIView {

  let rGradient = GradientView()
  let gGradient = GradientView()
  let bGradient = GradientView()
  let wGradient = GradientView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    subviews
      .filter { $0 is GradientView }
      .forEach { $0.frame = bounds }
  }

  fileprivate func setup() {
    backgroundColor = .white
    let views = [rGradient, gGradient, bGradient, wGradient]
    addSubviews(views)

    rGradient.direction = GradientView.Direction(start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 1.0, y: 1.0))
    gGradient.direction = GradientView.Direction(start: CGPoint(x: 0.0, y: 1.0), end: CGPoint(x: 1.0, y: 0.0))
    bGradient.direction = GradientView.Direction(start: CGPoint(x: 1.0, y: 1.0), end: CGPoint(x: 0.0, y: 0.0))
    wGradient.direction = GradientView.Direction(start: CGPoint(x: 1.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0))

    rGradient.colors = [(1.0, 0.0), (0.0, 1.0)].map {
      GradientView.Color(color: UIColor.red.withAlphaComponent($0.0), location: CGFloat($0.1))
    }
    gGradient.colors = [(1.0, 0.0), (0.0, 1.0)].map {
      GradientView.Color(color: UIColor.green.withAlphaComponent($0.0), location: CGFloat($0.1))
    }
    bGradient.colors = [(1.0, 0.0), (0.0, 1.0)].map {
      GradientView.Color(color: UIColor.blue.withAlphaComponent($0.0), location: CGFloat($0.1))
    }
    wGradient.colors = [(0.5, 0.0), (0.0, 1.0)].map {
      GradientView.Color(color: UIColor.black.withAlphaComponent($0.0), location: CGFloat($0.1))
    }
  }
}
