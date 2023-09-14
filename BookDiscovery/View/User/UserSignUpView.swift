//
//  UserSignUpView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

struct UserSignUpView: View {
    @StateObject var userModel = UserModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isValidEmail: Bool = false
    @State private var passwordsMatch: Bool = false
    @State private var showPassword: Bool = false
    
    @State private var isEmailFocused: Bool = false
    @State private var isPasswordFocused: Bool = false
    @State private var isConfirmPasswordFocused: Bool = false
    @State private var signUpSuccess = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center) {
                Spacer()
                Text("Create Account")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.vertical, 20)
                
                VStack (spacing: 12) {
                    
                    /// EMAIL TEXT & TEXTFIELD
                    VStack (spacing: 4) {
                        HStack {
                            Text("Email")
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                .foregroundColor(isEmailFocused ? Color.black : Color.gray)
                            
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: geometry.size.width * 0.8 + 16, height: 44)
                                .foregroundColor(Color.white)
                            
                            TextField("", text: $email)
                                .autocapitalization(.none)  // Disable automatic capitalization
                                .disableAutocorrection(true) // Disable autocorrection
                                .padding(.horizontal)
                                .onTapGesture {
                                    isEmailFocused = true
                                    isPasswordFocused = false
                                    isConfirmPasswordFocused = false
                                }
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
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                .foregroundColor(isPasswordFocused ? Color.black : Color.gray)
                            
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: geometry.size.width * 0.8 + 16, height: 44)
                                .foregroundColor(Color.white)
                            
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
                                    .onTapGesture {
                                        isEmailFocused = false
                                        isPasswordFocused = true
                                        isConfirmPasswordFocused = false
                                    }
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.showPassword.toggle()
                                }) {
                                    Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill")
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
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                .foregroundColor(isConfirmPasswordFocused ? Color.black : Color.gray)
                            
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: geometry.size.width * 0.8 + 16, height: 44)
                                .foregroundColor(Color.white)
                            
                            SecureField("", text: $confirmPassword, onCommit: {
                                self.passwordsMatch = (password == confirmPassword)
                            })
                            .font(.system(size: 20, weight: .regular))
                            .autocapitalization(.none)  // Disable automatic capitalization
                            .disableAutocorrection(true) // Disable autocorrection
                            .padding(.horizontal)
                            .onTapGesture {
                                isEmailFocused = false
                                isPasswordFocused = false
                                isConfirmPasswordFocused = true
                            }
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
                
                Button("Sign Up") {
                   userSignUp()
                }
                .foregroundColor(.black)
                .font(.system(size: 24, weight: .semibold))
//                .disabled(!isValidEmail || !passwordsMatch || password.isEmpty || confirmPassword.isEmpty)
                .padding(.vertical, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
                //            .frame(width: geometry.size.width, height: geometry.size.height)
            .frame(width: geometry.size.width, height: 750)
            .onTapGesture {
                isEmailFocused = false
                isPasswordFocused = false
                isConfirmPasswordFocused = false
            }
        }
    }
    
    // function to handle user sign up
    func userSignUp() {
        if isValidInput() {
            FirebaseAuthService().signUp(email: email, password: password) { (success, error) in
                if success {
                    print("User signed up successfully")
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
        UserSignUpView()
    }
}
