
// Import required modules
import SwiftUI
import Firebase
import UserNotifications

// UserProfileView SwiftUI View
struct UserProfileView: View {
    // ViewModel to manage user state
    @ObservedObject var userViewModel: UserViewModel

    // Local states for UI elements
    @State private var enabledEdit: Bool = false
    @State private var user: User?
    @State private var showToast: Bool = false
    @State private var userBGImage: UIImage = UIImage(named: "background")!
    @State private var userImage: UIImage = UIImage(named: "profile")!

    // Main View body
    var body: some View {
        NavigationStack {
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
                        ProfileBackgroundView(bgImage: userBGImage)
                        ProfileImageView(profileImage: userImage)
                    }
                    
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
                            .font(.system(size: 24, weight: .semibold))
                        }
                        else {
                            Text(userViewModel.currentUser.name == "" ? "Empty Name" : userViewModel.currentUser.name )
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(userViewModel.currentUser.name == "" ? .gray : .black)
                        }
                        
                        Spacer()
                        // Edit/Update button section
                        
                        // Cancel button appears only when editing
                        Button {
                            enabledEdit.toggle()
                        } label: {
                            Text("Cancel")
                                .opacity(enabledEdit ? 1 : 0)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                        // Edit/Update toggle button
                        Button {
                            enabledEdit.toggle()
                            
                            // Update user data
                            if enabledEdit == false {
                                if let user = user {
                                    FireBaseDB().updateUser(user: user) { _ in
                                        showToast = true
                                        userViewModel.currentUser = user
                                        
                                        // Hide toast after 3 seconds
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            showToast = false
                                        }
                                    }
                                } else {
                                    
                                }
                            }
                        } label: {
                            Text(enabledEdit ? "Update" : "Edit")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(height: 40)
                    .padding(.horizontal, 20)

                    // Separation divider
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 1)
                        .background(.gray)
                        .padding(.vertical)
                    
                    // Email and Address section
                    VStack (spacing: 16) {
                        // Email display
                        HStack {
                            Text("Email: ")
                                .font(.system(size: 20, weight: .semibold))
                            Text(userViewModel.currentUser.email )
                                .padding(.horizontal)
                                .font(.system(size: 16, weight: .regular))
                            Spacer()
                        }
                        
                        // Address (Street, City, Country) input/TextFields
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
                    }
                    .padding(.horizontal, 20)
                    
                    // Separation divider
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 1)
                        .background(.gray)
                        .padding(.vertical)
                    
                    // User bio section
                    VStack (alignment: .center) {
                        // Conditional TextEditor or Text based on editing mode
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
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(height: 100)
                            .padding()
                    )
                }
                
                // Buttons Section
                VStack (spacing: 8) {

                    // Button to go to ResetPasswordView
                    NavigationLink(destination: ResetPasswordView(userViewModel: userViewModel)) {
                        Text("Reset Password")
                    }
                    
                    // Button to go to ChangePasswordView
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                    }
                    
                    // Sign-out button
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

             }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                
                // Fetch current user data and images when view appears
                user = userViewModel.currentUser
                fetchUserData()
                fetchUserImage()
//                userViewModel.currentUser = testUser
            }
        }
    }
    
    // Fetch profile and background images
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
    
    // Fetch user data from Firebase
    func fetchUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            FireBaseDB().fetchUser(userID: userID) { fetchedUser in
                self.user = fetchedUser
            }
        }
    }
    

}

// Preview for SwiftUI
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userViewModel: UserViewModel())
    }
}
