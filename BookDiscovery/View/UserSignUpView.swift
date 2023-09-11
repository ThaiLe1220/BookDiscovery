//
//  UserSignUpView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

struct UserSignUpView: View {
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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
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
                        }
                        .font(.system(size: 18))
                        .onTapGesture {
                            isEmailFocused = true
                            isPasswordFocused = false
                            isConfirmPasswordFocused = false
                        }
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
                                    .padding(.horizontal)                            }
                            
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
                        .onTapGesture {
                            isEmailFocused = false
                            isPasswordFocused = true
                            isConfirmPasswordFocused = false
                        }
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
                        }
                        .font(.system(size: 18))
                        .onTapGesture {
                            isEmailFocused = false
                            isPasswordFocused = false
                            isConfirmPasswordFocused = true
                        }
                        .onChange(of: confirmPassword) { _ in
                            if confirmPassword != password {
                                passwordsMatch = false
                            }  else {
                                passwordsMatch = true
                            }
                            print(passwordsMatch)
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.8)
                
                Button("Sign Up") {
                   signUp()
                }
                .foregroundColor(.black)
                .disabled(!isValidEmail || !passwordsMatch || password.isEmpty || confirmPassword.isEmpty)
                .padding(.vertical, 20)

            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .border(Color.black)
            .onTapGesture {
                isEmailFocused = false
                isPasswordFocused = false
                isConfirmPasswordFocused = false
            }
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView()
    }
}
