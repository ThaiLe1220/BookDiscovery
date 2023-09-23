//
//  TestView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI


struct TestView: View {
    let fonts = ["Arial", "Courier New", "Georgia", "Gill Sans", "Helvetica", "Helvetica Neue", "Times New Roman", "Verdana", "Zapfino", "Palatino"]
     
     var body: some View {
         ScrollView {
             VStack(alignment: .leading, spacing: 10) {
                 ForEach(fonts, id: \.self) { font in
                     Text("\(font)")
                         .font(.custom(font, size: 20))
                         .padding(.vertical, 5)
                         .background(Color.gray.opacity(0.1))
                         .cornerRadius(5)
                 }
             }
             .padding()
         }
         .navigationTitle("Font Styles")
     }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
