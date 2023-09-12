//
//  TestBEView.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

import SwiftUI
import Firebase

struct TestBEView: View {
    // MARK: - Variables
    
//    var user: User = User(
//        id: Auth.auth().currentUser?.uid ?? "",
//        email: Auth.auth().currentUser?.email ?? "",
//        name: "Full Name",
//        address: Address(
//            street: "street 1",
//            city: "city 1",
//            country: "country 1"
//        ),
//        bio: ""
//    )
    
    var body: some View {
        
        VStack {
            HStack {

                Button {
                    
                } label: {
                    Text("Update")
                }
                .padding(.horizontal)
                

                Button {

                } label: {
                    Text("Change password")
                }
                .padding(.horizontal)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct TestBEView_Previews: PreviewProvider {
    static var previews: some View {
        TestBEView()
    }
}
