//
//  UserSignInView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

// UserSignInView represents the sign-in screen in the app.
struct UserSignInView: View {
    // ViewModel to manage user-related data.
    @ObservedObject var userViewModel: UserViewModel
    
    // State variables to manage UI elements and actions.
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var buttonScale: CGFloat = 1.0

    // Main View
    var body: some View {
        // ZStack to overlay UI components.
        ZStack {
            // Background image.
            Image("wall-e")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.85)

            // GeometryReader for adaptive layout.
            GeometryReader { geometry in
                // Main VStack for vertically aligned UI components.
                VStack (alignment: .center) {
                    Spacer()
                    // "Sign In" header.
                    Text("Sign In")
                        .font(.system(size: 40, weight: .semibold, design: .default))
                        .padding(.vertical, 20)
                        .foregroundColor(.white)
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .mask(
                            Text("Sign In")
                                .font(.system(size: 34, weight: .bold, design: .serif))
                        )
                    
                    // VStack containing Email and Password text fields.
                    VStack (spacing: 12) {
                        // Email input section.
                        VStack (spacing: 4) {
                          HStack {
                              Text("Email")
                                  .font(.system(size: 18, weight: .semibold))
                                  .foregroundColor(.white) // Fallback color
                                  .overlay(
                                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
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
                                  .foregroundColor(Color(UIColor.quaternaryLabel))
                                  .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 7)
                                          .stroke(Color.clear, lineWidth: 1)
                                          .overlay(
                                            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                                             startPoint: .leading,
                                                             endPoint: .trailing)
                                          )
                                          .mask(
                                              RoundedRectangle(cornerRadius: 7)
                                                  .stroke(lineWidth: 1)
                                          )
                                  )

                              
                              TextField("", text: $email)
                                  .autocapitalization(.none)
                                  .disableAutocorrection(true)
                                  .padding(.horizontal)
                                  .foregroundColor(.white)


                          }
                          .font(.system(size: 18))
                        }
                        
                        // Password input section.
                        VStack (spacing: 4) {
                          HStack {
                              Text("Password")
                                  .font(.system(size: 18, weight: .semibold))
                                  .foregroundColor(.white)
                                  .overlay(
                                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
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
//                                  .fill(Color.clear)
                                  .foregroundColor(Color(UIColor.quaternaryLabel))
                                  .frame(width: geometry.size.width * 0.8 + 18, height: 46)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 7)
                                          .stroke(Color.clear, lineWidth: 1)
                                          .overlay(
                                            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
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
                                      .autocapitalization(.none)
                                      .disableAutocorrection(true)
                                      .padding(.horizontal)
                                      .foregroundColor(.white)

                              } else {
                                  SecureField("", text: $password)
                                      .autocapitalization(.none)
                                      .disableAutocorrection(true)
                                      .padding(.horizontal)
                                      .foregroundColor(.white)
                              }

                              HStack {
                                  Spacer()
                                  Button(action: {
                                      self.showPassword.toggle()
                                  }) {
                                      Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill")
                                          .foregroundColor(.orange)
                                  }
                                  .padding(.horizontal)
                              }
                          }
                          .font(.system(size: 18))
                        }
                        
                        HStack {
                            Spacer()
                            NavigationLink(destination: ResetPasswordView(userViewModel: userViewModel)) {
                                Text("Forgot Password")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.orange)
                                    .italic()
                            }
               
                        }
                      }
                      .frame(width: geometry.size.width * 0.8)
                    
                    // Sign In button and Face ID button.
                    ZStack {
                        
                        // Sign In button
                        Button(action: {
                            self.buttonScale = 0.8
                            withAnimation {
                                self.buttonScale = 1
                            }
                            
                            // Your sign-in logic here
                            FirebaseAuthService().signIn(email: email, password: password) { (success, error) in
                                if success {
                                    print("User signed in successfully")
                                    self.userViewModel.isSignedIn = true
                                } else {
                                    print("Failed to sign in")
                                    self.alertMessage = error?.localizedDescription ?? "Unknown error"
                                    self.showAlert = true
                                }
                            }
                        }) {
                            Text("Sign In")
                                .scaleEffect(self.buttonScale)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 40)
                        }
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
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
                        
                        // Biometric authentication button.
                        // Test on simulator. Use Features -> FaceID -> Matching Face
                        HStack {
                            Spacer()
                            Button {
                                FirebaseAuthService().biometricAuthentication() { (success, error) in
                                    if success {
                                        print("User signed in by face id successfully")
                                        self.userViewModel.isSignedIn = true
                                    } else {
                                        print("Failed to sign in by face id")
                                        self.alertMessage = error?.localizedDescription ?? "Unknown error"
                                        self.showAlert = true
                                    }
                                }

                            } label: {
                                HStack {
                                    Image(systemName: "faceid")  // Face ID icon
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                }
                                .padding(8)
                                .foregroundColor(.orange)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.orange, lineWidth: 1)
                                )
                                .padding(.horizontal, geometry.size.width * 0.1 - 8)
                            }
                        }

                    }
                    .padding(.vertical, 20)

                    // Navigation link to UserSignUpView.
                    NavigationLink(destination: UserSignUpView(userViewModel: userViewModel)) {
                        Text("Don't have an account? Sign Up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.orange)

                    }
                    


                    Spacer()
                }
                .frame(width: geometry.size.width, height: 750)
            }
                .offset(y: -UIScreen.main.bounds.height*0.08)
        }
    }
}

// SwiftUI Preview
struct UserSignInView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignInView(userViewModel: UserViewModel())
    }
}
