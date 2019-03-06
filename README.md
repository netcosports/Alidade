# Astrarium

Utility components

[![Version](https://img.shields.io/cocoapods/v/Alidade.svg?style=flat)](https://cocoapods.org/pods/Alidade)
[![License](https://img.shields.io/cocoapods/l/Alidade.svg?style=flat)](https://cocoapods.org/pods/Alidade)
[![Platform](https://img.shields.io/cocoapods/p/Alidade.svg?style=flat)](https://cocoapods.org/pods/Alidade)

## Installation

```ruby
pod 'Alidade', '~> 1.2'
```

## Subspecs

All available features are avaiable in separated subspecs:

### Core

Basic extenstion for basic swift types, like: `CGRect`, `CGPoint`, `Sequence`, `UIColor` etc. For example very usefull safe index access:

```swift
guard let model = models[safe: index] else { return }
```

### Date

Date manipulating utils and operators for different cases like:
- Dates comparison, the comparison only by component
- Easy component access
- String formatting
- Components modification

```swift
let tomorrow = Date() + DateComponents(day: 1)
```

### Geometry

Some useful basic geometry concepts such as `Ray`, `Line` or Segment;

### Vectors

Useful operators set for manipulating basic UIKit/CoreGraphics types as multi-dimensional vectors. 
For example CGRect and UIEdgeInsets both are 4d vectors. It lets client do the following:

```swift
let rect: CGRect
let insets: UIEdgeInsets
let rectWithInsets = rect + insets
```

### String

To calculate and cache `String` and `NSAttributedString` text size. Also, the ability to convert and cache HTML to `NSAttributedString` using `NSAttributedString.DocumentType.html`.

### UI

Cool utils for UIView, such as

```swift
func addSubviews(_ subviews: [UIView])
func addSubviews(_ subviews: UIView...)
```

Custom views: `GradientView`, `PathView`

### UIExtension

Most useful is `UIScalable` protocol to let you work in the same proportions with the provided design. 
You need to setup smallets size from design as base value:

```swift
UI.setBaseWidths([.pad: 768, .phone: 375])
```

Then you can access adjusted value using `.ui` extension:

```swift
let width: CGFloat = 180.ui
```

Also, if you have separated modules or design, provided for you, have different screen sizes across the design. 
You can use `Intent` associated with your module:

```swift
UI.setBaseWidths([.pad: 768, .phone: 320], for: Module.intent)
// then you can access 
let width: CGFloat = 180.uiValue(for: Module.intent)
```

### Boxed

Box container for mutability properties in immutable containers:

```swift
public class Boxed<T> {
  public var value: T?
  public init(_ value: T? = nil) {
    self.value = value
  }
  public func flatMap<U>(_ transform: (T) -> U?) -> U? {
    return value.flatMap(transform)
  }
 }
```

### Flowable

Amazing and useful extensions for the creation and simultaneous object setup in-place. For example:

```swift
let label = UILabel {
  $0.text = "Text"
  $0.numberOfLines = 2
}
```

### FormatterPool

Tools for creation and cache different types of formatters. For 
Dates, DateInterval, Length, PersonNameComponents etc. 


