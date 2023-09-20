//
//  SplashScreen.swift
//  BookDiscovery
//
//  Created by Vu Tran Hoang on 20/09/2023.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("applogo")
            .cornerRadius(30)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
