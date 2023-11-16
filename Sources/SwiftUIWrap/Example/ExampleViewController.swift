//
//  ExampleViewController.swift
//  
//
//  Created by Maximilian Lemberg on 16.11.2023.
//

import UIKit

class ExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = ExampleSwiftUIView()
        let initialViewModelState = SwiftUIViewModel(data: "")
        let wrapper = SwiftUIWrapperView(frame: .zero, rootView: swiftUIView, viewModel: initialViewModelState)
        wrapper.primaryAction = {
            // Do something
        }
        wrapper.secondaryAction = {
            // Do something else
        }
                
        self.view.addSubview(wrapper)
    }
    
}
