# PullableScrollView

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)
![SwiftVersion](https://img.shields.io/badge/swift-5.7%2B-orange)

`PullableScrollView` is a `SwiftUI` component to integarate the missing pull to refresh functionality from scroll views.

## Usage
```
PullableScrollView(tintColor: .red,
                   refreshCallback: { callback in
                       // Fetch some data and invoke `callBack` to hide the indicator.
                   }, content: {
                       Text("Scroll view content")
                   })

```

## Install

### SwiftPM
```
https://github.com/pantelisss/PullableScrollView.git
```
