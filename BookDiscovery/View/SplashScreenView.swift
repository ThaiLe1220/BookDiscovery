//
//  SplashScreen.swift
//  BookDiscovery
//
//  Created by Vu Tran Hoang on 20/09/2023.
//

import SwiftUI

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive : Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            VStack {
                Image("applogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 128, height: 128)
                    .cornerRadius(20)

                Text("BlogReads")
                    .foregroundColor(.black.opacity(0.80))
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 2)) {
                    self.size = 1.2
                    self.opacity = 1.00
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(false))
    }
}
