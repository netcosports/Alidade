# Alidade

Utility components

[![Version](https://img.shields.io/cocoapods/v/Alidade.svg?style=flat)](https://cocoapods.org/pods/Alidade)
[![License](https://img.shields.io/cocoapods/l/Alidade.svg?style=flat)](https://cocoapods.org/pods/Alidade)
[![Platform](https://img.shields.io/cocoapods/p/Alidade.svg?style=flat)](https://cocoapods.org/pods/Alidade)

## Installation

```ruby
pod 'Alidade', '~> 5.0.0'
```

## Subspecs

All available features are avaiable in separated subspecs:

### Core

Basic extenstion for basic swift types, like: `CGRect`, `CGPoint`, `Sequence`, `UIColor` etc. For example very usefull safe index access:

```swift
guard let model = models[safe: index] else { return }
```

### Geometry

Some useful basic geometry concepts such as `Ray`, `Line` or `Segment`;

### Vectors

Added SIMD vectors type conformance to some CoreGraphics and UI structs: CGPoint, CGRect, UIEdgeInsets, etc.
Also 
Useful operators set for manipulating basic UIKit/CoreGraphics types as multi-dimensional vectors. 
For example CGRect and UIEdgeInsets both are 4d vectors. It lets client do the following:

```swift
let rect: CGRect
let insets: UIEdgeInsets
let rectWithInsets = rect + insets
let bounds = CGRect([0, 0, 640, 1136])
let size = CGSize([120, 60])
let origin = bounds.midpoint - (size * 0.5).pointValue
let frame = CGRect(origin: origin, size: size)
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

Accessor for setting shadow:
```swift
view.shadow = .init(color: shadowColor, blur: 10.0, opacity: 0.5, offset: .zero, path: nil)
```

Sketch/Zeplin shadow also:
```swift
view.shadow = .sketch(color: shadowColor, alpha: 0.5, bounds: shadowBounds, x: 0.0, y: 10.0, blur: 10.0, spread: 0.0)
```

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
N.B.! makes runtime increase retain count for Boxed object every time when struct with Boxed object passed via param into function

```swift
struct SomeData {
  let a = 1
  var b = 2.0
  let c = Boxed(false)
}

let immutable = SomeData()
immutable.a = 2 // is forbidden

var mutable = SomeData()
mutable.b = 2.0 // is valid for mutable instances

// is valid for both cases
immutable.c.value = false 
mutable.c.value = true
```

### Associatable

Makes using ObjC runtime association easier:

```swift
private enum SomeClassYouWantToExtendViaObjcAssociationConst {

    static var propertyName = 0

}

extension SomeClassYouWantToExtendViaObjcAssociation {

    var readwriteValue: PropertyType? {
        get { return associated.value(for: &SomeClassYouWantToExtendViaObjcAssociationConst.propertyName) }
        set { associated.set(newValue, for: &SomeClassYouWantToExtendViaObjcAssociationConst.propertyName) }
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

```swift
  let date = Date()
  let locale = Locale.current
  let template = "EEEEEEE, d MMM"
  let dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) ?? template
  let dateString = DateFormatter.cached(format: dateFormat, locale: locale)
      .string(from: date)
```
