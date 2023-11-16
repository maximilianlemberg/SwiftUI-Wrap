//
//  SwiftUIView.swift
//  
//
//  Created by Maximilian Lemberg on 16.11.2023.
//

import SwiftUI

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

#Preview {
    ExampleSwiftUIView()
}
