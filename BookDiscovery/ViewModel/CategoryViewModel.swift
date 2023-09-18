//
//  CategoryViewModel.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import Foundation

class CategoryViewModel {
    @Published var categories: [Category] = []
    
    init() {
        FireBaseDB().getAllCategories() { result in
            DispatchQueue.main.async {
                if let categoryData = result {
                    self.categories.append(categoryData)
                }
            }
        }
    }
    
    
}
