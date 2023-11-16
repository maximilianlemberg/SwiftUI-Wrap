// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI
import UIKit

class SwiftUIViewModel<T>: ObservableObject {
    @Published var data: T
    
    init(data: T) {
        self.data = data
    }
}

class SwiftUIWrapperView<Content, T>: UIView where Content: View {
    
    private var hostingController: UIHostingController<AnyView>?
    
    @Published var viewModel: SwiftUIViewModel<T> {
        didSet {
            updateSwiftUI()
        }
    }
    
    var primaryAction: (() -> Void)? {
        didSet {
            updateSwiftUI()
        }
    }
    var secondaryAction: (() -> Void)? {
        didSet {
            updateSwiftUI()
        }
    }

    private var rootView: Content

    init(frame: CGRect, rootView: Content, viewModel: SwiftUIViewModel<T>) {
        self.rootView = rootView
        self.viewModel = viewModel
        super.init(frame: frame)
        setupSwiftUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSwiftUI() {
        updateSwiftUI()
    }

    private func updateSwiftUI() {
        let modifiedRootView = rootView
            .environmentObject(viewModel)
            .environment(\.primaryAction, primaryAction ?? {})
            .environment(\.secondaryAction, secondaryAction ?? {})
        
        let host = UIHostingController(rootView: AnyView(modifiedRootView))
        hostingController?.view.removeFromSuperview()
        hostingController = host
        host.view.frame = self.bounds
        host.view.backgroundColor = .clear

        addSubview(host.view)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: topAnchor),
            host.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

struct PrimaryActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

struct SecondaryActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var primaryAction: () -> Void {
        get { self[PrimaryActionKey.self] }
        set { self[PrimaryActionKey.self] = newValue }
    }
    
    var secondaryAction: () -> Void {
        get { self[SecondaryActionKey.self] }
        set { self[SecondaryActionKey.self] = newValue }
    }
}
