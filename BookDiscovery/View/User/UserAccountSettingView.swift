/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 14/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

// Import required modules
import SwiftUI
import Firebase

// UserAccountSettingView SwiftUI View
struct UserAccountSettingView: View {
    // ViewModel to manage user state
    @ObservedObject var userViewModel: UserViewModel

    // Local states for UI elements
    @State private var enabledEdit: Bool = false
    @State private var showToast: Bool = false

    // Main View body
    var body: some View {
        ZStack {
            // Main scroll view
            ScrollView {
                // Toast message when data updated
                if showToast {
                    VStack {
                        ToastView(message: "Updated!")
                        Spacer()
                    }
                }
                
                // Main vertical stack (user profile, cover, email, address)
                VStack {
                    // Profile and background image section
                    ZStack {
                        ProfileBackgroundView(userViewModel: userViewModel)
                        ProfileImageView(userViewModel: userViewModel)
                            .offset(x: -UIScreen.main.bounds.width/2 + 80, y: 90)
                        
                        // Name editing and button controls
                        HStack {
                            // Conditional TextField or Text based on editing mode
                            if enabledEdit {
                                TextField("Name", text: Binding<String>(
                                    get: { userViewModel.currentUser.name },
                                    set: { newValue in
                                        userViewModel.currentUser.name = newValue
                                    }
                                ))
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+8))
                                .fontWeight(.semibold)
                                .foregroundColor(userViewModel.isOn ? .white : .black)
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection
                            }
                            else {
                                Text(userViewModel.currentUser.name == "" ? "Empty Name" : userViewModel.currentUser.name )
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+10))
                                    .fontWeight(.semibold)
                                    .foregroundColor(userViewModel.isOn ? .white : .black)
                            }
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width - 160)
                        .offset(x: -UIScreen.main.bounds.width/2 + 80 + 190, y: 110)
                        
                        HStack {
                            // Edit/Update button section
                            // Cancel button appears only when editing
                            Button {
                                enabledEdit.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    userViewModel.fetchUserImage()
                                    userViewModel.fetchUserData()
                                }
                            } label: {
                                Text("Cancel")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                                    .fontWeight(.semibold)
                                    .foregroundColor(userViewModel.isOn ? .white : .black)
                            }
                            .frame(width: 80, height: 5)
                            .padding(.vertical, 12)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
                            .opacity(enabledEdit ? 1 : 0)

                            // Edit/Update toggle button
                            Button {

                                if enabledEdit == true {
                                    FireBaseDB().updateUser(user: userViewModel.currentUser) { (success, error) in
                                        if success {
                                            print("User updated data successfully")
                                        } else {
                                            print (error?.localizedDescription ?? "Unknown error")
                                        }
                                    }
                                }
                                enabledEdit.toggle()
                                
                            } label: {
                                Text(enabledEdit ? "Update" : "Edit")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                                    .fontWeight(.semibold)
                                    .foregroundColor(userViewModel.isOn ? .white : .black)
                            }
                            .frame(width: enabledEdit ? 80 : 60, height: 5)
                            .padding(.vertical, 12)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
                        }
                        .offset(x: UIScreen.main.bounds.width/2 - 90, y: 65)

                    }
                    Spacer().frame(height: 80)
                    
                    // Email and Address section
                    VStack (spacing: 8) {
                        // Email display
                        HStack {
                            HStack {
                                Text("Email: ")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("GreyMain"))
                                Spacer()
                            }
                            .frame(width: 80)

                            Text(userViewModel.currentUser.email )
                                .padding(.horizontal)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.regular)
                                .foregroundColor(Color("OrangeMain"))

                            Spacer()
                        }
                        
                        // Address (Street, City, Country) input/TextFields
                        HStack {
                            HStack {
                                Text("Street: ")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("GreyMain"))
                                Spacer()
                            }
                            .frame(width: 80)

                            if enabledEdit {
                                TextField("Street", text: Binding<String>(
                                    get: { userViewModel.currentUser.address.street },
                                    set: { newValue in
                                        userViewModel.currentUser.address.street = newValue
                                    }
                                ))
                                .padding(.horizontal)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.regular)
                                .foregroundColor(Color("OrangeMain"))
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color(UIColor.systemGray6))
                                        .frame(height: 25)
                                )
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection
                                
                            } else {
                                Text(userViewModel.currentUser.address.street == "" ? "please update information" : userViewModel.currentUser.address.street)
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.currentUser.address.street == "" ? userViewModel.selectedFontSize-2 : userViewModel.selectedFontSize))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(userViewModel.currentUser.address.street == "" ? "GreyMain" : "OrangeMain"))
                                    .italic(userViewModel.currentUser.address.street.isEmpty)
                                
                            }
                            
                            Spacer()
                        }
                        HStack {
                            HStack {
                                Text("City: ")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("GreyMain"))
                                Spacer()
                            }
                            .frame(width: 80)

                            if enabledEdit {
                                TextField("City", text: Binding<String>(
                                    get: { userViewModel.currentUser.address.city },
                                    set: { newValue in
                                        userViewModel.currentUser.address.city = newValue
                                    }
                                ))
                                .padding(.horizontal)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("OrangeMain"))
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color(UIColor.systemGray6))
                                        .frame(height: 25)
                                )
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection
                                
                            } else {
                                Text(userViewModel.currentUser.address.city == "" ? "please update information" : userViewModel.currentUser.address.city)
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.currentUser.address.city == "" ? userViewModel.selectedFontSize-2 : userViewModel.selectedFontSize))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(userViewModel.currentUser.address.city == "" ? "GreyMain" : "OrangeMain"))
                                    .italic(userViewModel.currentUser.address.city.isEmpty)
                            }
                            
                            Spacer()
                        }
                        HStack {
                            HStack {
                                Text("Country: ")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("GreyMain"))
                                Spacer()
                            }
                            .frame(width: 80)

                            if enabledEdit {
                                TextField("Country", text: Binding<String>(
                                    get: { userViewModel.currentUser.address.country },
                                    set: { newValue in
                                        userViewModel.currentUser.address.country = newValue
                                    }
                                ))
                                .padding(.horizontal)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.regular)
                                .foregroundColor(Color("OrangeMain"))
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color(UIColor.systemGray6))
                                        .frame(height: 25)
                                )
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection
                                
                            } else {
                                Text(userViewModel.currentUser.address.country == "" ? "please update information" : userViewModel.currentUser.address.country)
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.currentUser.address.country == "" ? userViewModel.selectedFontSize-2 : userViewModel.selectedFontSize))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(userViewModel.currentUser.address.country == "" ? "GreyMain" : "OrangeMain"))
                                    .italic(userViewModel.currentUser.address.country.isEmpty)
                            }
                            Spacer()
                        }
                    }
                    .padding(12)
                    .background(userViewModel.isOn ? .black : .white)
                    .cornerRadius(5)
                    .padding(.horizontal, 16)
                    
                    // User bio section
                    Section {
                        HStack (alignment: .center) {
                            // Conditional TextEditor or Text based on editing mode
                            if enabledEdit {
                                TextField("Bio", text: Binding<String>(
                                    get: { userViewModel.currentUser.bio },
                                    set: { newValue in
                                        userViewModel.currentUser.bio = newValue
                                    }
                                ), axis: .vertical)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.regular)
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection

                            } else {
                                Text(userViewModel.currentUser.bio )
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(UIColor.gray))
                            }
                            Spacer()
                        }
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                        .padding(12)
                        .background(userViewModel.isOn ? .black : .white)
                        .cornerRadius(5)
                        .padding(.horizontal, 16)
                    }
                }
                
                // Buttons Section
                VStack (spacing: 8) {
                    // Button to go to ChangePasswordView
                    NavigationLink(destination: ChangePasswordView(userViewModel: userViewModel)) {
                        Spacer()
                        Text("Change Password")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.red)
                    .padding(12)
                    .background(userViewModel.isOn ? .black : .white)
                    .cornerRadius(5)
                    .padding(.horizontal, 16)
                    
                    // Sign-out button
                    Button {
                        FirebaseAuthService().signOut() { (success, error) in
                            if success {
                                print("User signed out successfully")
                                userViewModel.isSignedIn = false

                            } else {
                                print (error?.localizedDescription ?? "Unknown error")
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Sign out")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                        .padding(12)
                        .background(userViewModel.isOn ? .black : .white)
                        .cornerRadius(5)
                        .padding(.horizontal, 16)
                    }
                                        
                    // Delete button
                    Button {
                        FireBaseDB().deleteUser() { success in
                            if success {
                                print("Deleted successfully")
                                userViewModel.isSignedIn = false
                            } else {
                                print("Failed to delete")
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Account")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                        .padding(12)
                        .background(userViewModel.isOn ? .black : .white)
                        .cornerRadius(5)
                        .padding(.horizontal, 16)
                    }
                }
             }
            .background(Color(UIColor.secondarySystemBackground))
            .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    CustomBackButton(userViewModel: userViewModel, buttonColor: Color(UIColor.black), text: "Settings")
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
//            userViewModel.currentUser = testUser
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
    
    
}

// Preview for SwiftUI
struct UserAccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountSettingView(userViewModel: UserViewModel())
    }
}
