<p align="center">
<img alt="ReactorKit" src="https://cloud.githubusercontent.com/assets/931655/25277625/6aa05998-26da-11e7-9b85-e48bec938a6e.png" style="max-width: 50%">
<img alt="SwiftUI" src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" style="max-width: 50%">
</p>

<p align="center">
  <img alt="Swift" src="https://img.shields.io/badge/Swift-5.0-orange.svg">
</p>

# ReactorKit-SwiftUI

ReactorKit-SwiftUI is an extension of [devxoul's ReactorKit](https://github.com/ReactorKit/ReactorKit), specifically designed to work with [SwiftUI](https://developer.apple.com/xcode/swiftui).

## Usage

```swift
let reactor = MyReactor() // A reactor is the same as in ReactorKit.
let view = MyView(reactor: reactor)

struct MyView: ReactorView {
  var reactor: MyReactor
  
  func body(reactor: MyReactor.ObservableObject) -> some View {
    // this is called when the state updates.
  }
}
```

## Use Cases
ReactorKit-SwiftUI is useful in the following scenarios:
- When you want to convert your existing ReactorKit-based project to SwiftUI while keeping all business logic unchanged.
- When you are using RxSwift and want to apply SwiftUI in your project.
- When you want to use both ReactorKit and SwiftUI together seamlessly.

## Examples

- [Counter](https://github.com/gunoooo/ReactorKit-SwiftUI/tree/master/Examples/Counter): The most simple and basic example of SwiftUI-ReactorKit

## Dependencies

- [ReactorKit](https://github.com/ReactorKit/ReactorKit) >= 3.0.0

## Requirements

- Swift 5
- iOS 13
- macOS 10.15
- tvOS 13.0
- watchOS 6.0

## Installation

**Podfile**

```
# Preparing..
```

**Package.swift**

```swift
let package = Package(
  // ...
  dependencies: [
    .package(url: "https://github.com/gunoooo/ReactorKit-SwiftUI.git", .upToNextMajor(from: "0.0.1"))
  ],
  // ...
)
```

ReactorKit-SwiftUI does not support Carthage.

## License

ReactorKit-SwiftUI is under MIT license. See the [LICENSE](https://github.com/gunoooo/ReactorKit-SwiftUI/blob/master/LICENSE) for more info.
