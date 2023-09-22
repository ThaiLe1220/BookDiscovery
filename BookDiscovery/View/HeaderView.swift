//
//  SwiftUIView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 22/09/2023.
//

import SwiftUI

struct HeaderView: View {
    @State private var showProfile = false
    
    var body: some View {
        HStack {
            Text("Tab Name")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                showProfile.toggle()
            }) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .sheet(isPresented: $showProfile) {
                UserProfileView()
            }
        }
        .padding()
    }
}

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Done") {
                    dismiss()
                }
            )
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
