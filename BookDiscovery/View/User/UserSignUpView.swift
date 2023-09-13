//
//  UserSignUpView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

struct UserSignUpView: View {
    @ObservedObject var userViewModel: UserViewModel

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isValidEmail: Bool = false
    @State private var passwordsMatch: Bool = false
    @State private var showPassword: Bool = false
    @State private var signUpSuccess = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var buttonScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Image("wall-e")
                .resizable()
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack (alignment: .center) {
                    Spacer()
                    Text("Create Account")
                        .font(.system(size: 36, weight: .semibold))
                        .padding(.vertical, 20)
                        .foregroundColor(.white)
                    
                    VStack (spacing: 12) {
                        
                        /// EMAIL TEXT & TEXTFIELD
                        VStack (spacing: 4) {
                            HStack {
                                Text("Email")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white) // Fallback color
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing)
                                    )
                                    .mask(
                                        Text("Email")
                                            .font(.system(size: 18, weight: .semibold))
                                    )

                                Spacer()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.clear)
                                    .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .overlay(
                                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                               startPoint: .leading,
                                                               endPoint: .trailing)
                                            )
                                            .mask(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(lineWidth: 1)
                                            )
                                    )
                                
                                TextField("", text: $email)
                                    .autocapitalization(.none)  // Disable automatic capitalization
                                    .disableAutocorrection(true) // Disable autocorrection
                                    .padding(.horizontal)
                            }
                            .font(.system(size: 18))
       
                            .onChange(of: email) { _ in
                                isValidEmail = validateEmail(email)
                            }
                        }
                        
                        /// PASSWORD TEXT & TEXTFIELD
                        VStack (spacing: 4) {
                            HStack {
                                Text("Password")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white) // Fallback color
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing)
                                    )
                                    .mask(
                                        Text("Password")
                                            .font(.system(size: 18, weight: .semibold))
                                    )

                                Spacer()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.clear)
                                    .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .overlay(
                                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                               startPoint: .leading,
                                                               endPoint: .trailing)
                                            )
                                            .mask(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(lineWidth: 1)
                                            )
                                    )
                                
                                if showPassword {
                                    TextField("", text: $password)
                                        .autocapitalization(.none)  // Disable automatic capitalization
                                        .disableAutocorrection(true) // Disable autocorrection
                                        .padding(.horizontal)
                                } else {
                                    SecureField("", text: $password)
                                        .autocapitalization(.none)  // Disable automatic capitalization
                                        .disableAutocorrection(true) // Disable autocorrection
                                        .padding(.horizontal)
                                }
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.showPassword.toggle()
                                    }) {
                                        Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(.white)

                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .font(.system(size: 18))

                        }
                        
                        /// CONFIRM PASSWORD TEXT & TEXTFIELD
                        VStack (spacing: 4) {
                            HStack {
                                Text("Confirm Password")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white) // Fallback color
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing)
                                    )
                                    .mask(
                                        Text("Confirm Password")
                                            .font(.system(size: 18, weight: .semibold))
                                    )

                                Spacer()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.clear)
                                    .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .overlay(
                                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                               startPoint: .leading,
                                                               endPoint: .trailing)
                                            )
                                            .mask(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(lineWidth: 1)
                                            )
                                    )
                                
                                SecureField("", text: $confirmPassword, onCommit: {
                                    self.passwordsMatch = (password == confirmPassword)
                                })
                                .font(.system(size: 20, weight: .regular))
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection
                                .padding(.horizontal)
                            }
                            .font(.system(size: 18))
                            .onChange(of: confirmPassword) { _ in
                                if confirmPassword != password {
                                    passwordsMatch = false
                                }  else {
                                    passwordsMatch = true
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.8)
                    
                    Button(action: {
                        self.buttonScale = 0.8
                        withAnimation {
                            self.buttonScale = 1
                        }
                        
                        // Your sign-up logic here
                        userSignUp()

                    }) {
                        Text("Sign Up")
                            .scaleEffect(self.buttonScale)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 40)
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(25)
                    .font(.system(size: 20, weight: .semibold))
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Invalid Input"),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("OK")))
                    }
                    .padding(.vertical, 20)
                    Spacer()
                }
                .frame(width: geometry.size.width, height: 750)
            }
        }
    }
    
    // function to handle user sign up
    func userSignUp() {
        if isValidInput() {
            FirebaseAuthService().signUp(email: email, password: password) { (success, error) in
                if success {
                    print("User signed up successfully")
                    self.userViewModel.isSignedIn = true
                } else {
                    self.alertMessage = error?.localizedDescription ?? "Unknown error"
                    self.showAlert = true
                }
            }
        } else {
            self.showAlert = true
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func isValidInput() -> Bool {
        if !isValidEmail {
            alertMessage = "Please enter a valid email address."
            return false
        }
        
        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            return false
        }
        
        if !passwordsMatch {
            alertMessage = "Passwords do not match."
            return false
        }
        
        return true
    }
}

struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView(userViewModel: UserViewModel())
    }
}
