//
//  UserProfileView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase
import UserNotifications

struct UserProfileView: View {
    @ObservedObject var userViewModel: UserViewModel

    @State private var enabledEdit: Bool = true
    @State private var user: User?

    @State private var showToast: Bool = false
    
    @State private var userBGImage: UIImage = UIImage(named: "background")!
    @State private var userImage: UIImage = UIImage(named: "profile")!

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ProfileBackgroundView(bgImage: userBGImage)
                    
                    HStack {
                        ProfileImageView(profileImage: userImage)
                            .offset(y: -70)
                            .padding(.bottom, -55)
                            .padding(.horizontal, 20)
                        
                        if enabledEdit {
                            TextField("Name", text: Binding<String>(
                                get: { userViewModel.currentUser.name },
                                set: { newValue in
                                    userViewModel.currentUser.name = newValue
                                }
                            ))
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.horizontal)

                            
                        } else {
                            Text(userViewModel.currentUser.name )
                                .font(.system(size: 24, weight: .semibold))
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 40)

                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 1)
                        .background(.gray)
                        .padding(.vertical)

                    HStack {
                        Text("Email: ")
                            .font(.system(size: 20, weight: .semibold))
                        Text(userViewModel.currentUser.email )
                            .padding(.horizontal)
                            .font(.system(size: 16, weight: .regular))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 6)
                    
                    HStack {
                        Text("Street: ")
                            .font(.system(size: 20, weight: .semibold))

                        if enabledEdit {
                            TextField("Street", text: Binding<String>(
                                get: { userViewModel.currentUser.address.street },
                                set: { newValue in
                                    userViewModel.currentUser.address.street = newValue
                                }
                            ))
                            .padding(.horizontal)
                            .font(.system(size: 16, weight: .regular))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(height: 30)
                            )
                            
                        } else {
                            Text(userViewModel.currentUser.address.country )
                                .padding(.horizontal)
                                .font(.system(size: 16, weight: .regular))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 6)
                    
                    HStack {
                        Text("City: ")
                            .font(.system(size: 20, weight: .semibold))

                        if enabledEdit {
                            TextField("City", text: Binding<String>(
                                get: { userViewModel.currentUser.address.city },
                                set: { newValue in
                                    userViewModel.currentUser.address.city = newValue
                                }
                            ))
                            .padding(.horizontal)
                            .font(.system(size: 16, weight: .regular))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(height: 30)
                            )

                        } else {
                            Text(userViewModel.currentUser.address.city )
                                .padding(.horizontal)
                                .font(.system(size: 16, weight: .regular))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 6)
                    
                    HStack {
                        Text("Country: ")
                            .font(.system(size: 20, weight: .semibold))
                        if enabledEdit {
                            TextField("Country", text: Binding<String>(
                                get: { userViewModel.currentUser.address.country },
                                set: { newValue in
                                    userViewModel.currentUser.address.country = newValue
                                }
                            ))
                            .padding(.horizontal)
                            .font(.system(size: 16, weight: .regular))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(height: 30)
                            )
                        } else {
                            Text(userViewModel.currentUser.address.country )
                                .padding(.horizontal)
                                .font(.system(size: 16, weight: .regular))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 6)
                    
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 1)
                        .background(.gray)
                        .padding(.vertical)
                    
                    
                    VStack (alignment: .center) {
                        if enabledEdit {
                            TextEditor(text: Binding<String>(
                                get: { userViewModel.currentUser.bio },
                                set: { newValue in
                                    userViewModel.currentUser.bio = newValue
                                }
                            ))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 20)
                        } else {
                            Text(userViewModel.currentUser.bio )
                                .font(.system(size: 16, weight: .regular))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 20)
                        }
                    }
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: UIScreen.main.bounds.width, height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(height: 100)
                            .padding()
                    )
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        enabledEdit.toggle()
                    } label: {
                        Text("Cancel")
                            .opacity(enabledEdit ? 1 : 0)
                    }
                    .padding()
                    
                    Button {
                        enabledEdit.toggle()
                        if enabledEdit == false {
                            if let user = user {
                                FireBaseDB().updateUser(user: user) { _ in
                                    showToast = true
                                    userViewModel.currentUser = user
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        showToast = false
                                    }
                                }
                            } else {
                                
                            }
                        }
                        
                        
                    } label: {
                        Text(enabledEdit ? "Update" : "Edit")
                    }
                    .padding()
                }
                
                Spacer()
                Button("Sign Out") {
                    FirebaseAuthService().signOut() { (success, error) in
                        if success {
                            print("User signed out successfully")
                            self.userViewModel.isSignedIn = false

                        } else {
                            print (error?.localizedDescription ?? "Unknown error")
                        }
                    }
                }

            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                user = userViewModel.currentUser
                fetchUserData()
                fetchUserImage()
                userViewModel.currentUser = testUser
            }
            if showToast {
                VStack {
                    ToastView(message: "Updated!")
                    Spacer()
                }
            }
        }
    }
    
    func fetchUserImage() {
        ImageStorage().getProfile() { result in
            DispatchQueue.main.async {
                if let image = result {
                    self.userImage = image
                }
            }
        }
        
        ImageStorage().getBackground() { result in
            DispatchQueue.main.async {
                if let image = result {
                    self.userBGImage = image
                }
            }
        }
    }
    
    func fetchUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            FireBaseDB().fetchUser(userID: userID) { fetchedUser in
                self.user = fetchedUser
            }
        }
    }
    

}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userViewModel: UserViewModel())
    }
}
