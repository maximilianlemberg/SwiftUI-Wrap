# SwiftUI-Wrap 🌯

Welcome to **SwiftUI-Wrap**, a Swift package designed to seamlessly integrate SwiftUI Views into UIKit-based projects. This package allows for the effortless creation of SwiftUI views within traditional UIKit view hierarchies, bringing the power of SwiftUI to more traditional iOS app architectures.

## Features ✨
- Easy embedding of SwiftUI views in UIKit.
- Dynamic updating of SwiftUI views through observable objects.
- Custom primary and secondary actions within SwiftUI views.

## Requirements 📋
- iOS 13.0 or later
- Swift 5.9 or later

## Installation 🛠️

### Swift Package Manager
To use SwiftUI-Wrap with the Swift Package Manager, add it to the dependencies of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/maximilianlemberg/SwiftUI-Wrap.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage 💻

### Setting Up Your SwiftUI View

- Create your SwiftUI view as usual.
- Make sure it observes an ObservableObject for data updates.

###ExampleSwiftUIView.swift

```swift
struct ExampleSwiftUIView: View {
    @EnvironmentObject var viewModel: SwiftUIViewModel<String>
    @Environment(\.primaryAction) var primaryAction
    @Environment(\.secondaryAction) var secondaryAction

    var body: some View {
        Text(viewModel.data)
        Button(action: primaryAction) {
            Text("Primary Action")
        }
        Button(action: secondaryAction) {
            Text("Secondary Action")
        }
    }
}

```

###Wrapping SwiftUI View in UIKit

Use `SwiftUIWrapperView` to integrate your SwiftUI view into a UIKit-based environment.

###ExampleViewController.swift

```swift
import UIKit

class ExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = ExampleSwiftUIView()
        let initialViewModelState = SwiftUIViewModel(data: "")
        let wrapper = SwiftUIWrapperView(frame: .zero, rootView: swiftUIView, viewModel: initialViewModelState)
        wrapper.primaryAction = {
            // Primary Action
        }
        wrapper.secondaryAction = {
            // Secondary Action
        }
                
        self.view.addSubview(wrapper)
    }
}

```


### Handling Actions
You can define primary and secondary actions for your SwiftUI view which can be triggered from within the SwiftUI view context.

```swift
wrapper.primaryAction = {
    // Define primary action
}
wrapper.secondaryAction = {
    // Define secondary action
}

```

## Contributing 🤝
Contributions are welcome! If you want to contribute to this project, please submit a pull request or open an issue for discussion.

## License 📄
This project is licensed under the MIT License - see the [LICENSE](./License.txt) file for details.

---

Happy Coding! 🎉

