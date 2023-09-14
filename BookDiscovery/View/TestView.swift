//
//  TestView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

import SwiftUI

struct CustomDismissView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack {
                Text("Custom Dismiss View")
                
                // Add a custom button to dismiss the view
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationBarItems(leading: EmptyView()) // Remove any leading navigation items
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button

    }
}

struct TestView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Go to Custom Dismiss View", destination: CustomDismissView())
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
