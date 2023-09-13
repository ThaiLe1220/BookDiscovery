//
//  UserSignInView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

struct UserSignInView: View {
    @ObservedObject var userViewModel: UserViewModel

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
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
                    Text("Sign In")
                        .font(.system(size: 36, weight: .semibold))
                        .padding(.vertical, 20)
                        .foregroundColor(.white)
                    
                    VStack (spacing: 12) {
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
                                      .autocapitalization(.none)
                                      .disableAutocorrection(true)
                                      .padding(.horizontal)
                                      .foregroundColor(.white)


                              }
                              .font(.system(size: 18))
                          }

                          VStack (spacing: 4) {
                              HStack {
                                  Text("Password")
                                      .font(.system(size: 18, weight: .semibold))
                                      .foregroundColor(.white)
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
                                              .foregroundColor(.white)
                                      }
                                      .padding(.horizontal)
                                  }
                              }
                              .font(.system(size: 18))
                          }
                      }
                      .frame(width: geometry.size.width * 0.8)
                    
                    ZStack {
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
                        
                        // Button to test biometric authentication feature
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
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white, lineWidth: 1)
                                )
                                .padding(.horizontal, geometry.size.width * 0.1 - 8)
                            }
                        }

                    }
                    .padding(.vertical, 20)

                    NavigationLink(destination: UserSignUpView(userViewModel: userViewModel)) {
                        Text("Don't have an account? Sign Up")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: 750)
            }
        }
    }
}

struct UserSignInView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignInView(userViewModel: UserViewModel())
    }
}
