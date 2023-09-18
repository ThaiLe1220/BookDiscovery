//
//  CategoryView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import SwiftUI

struct CategoryView: View {
    var category: Category = testCategory
    
    var body: some View {
        ZStack {
            Image("")
                .resizable()
                .scaledToFit()
            
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
