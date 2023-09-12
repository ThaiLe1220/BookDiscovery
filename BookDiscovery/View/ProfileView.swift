//
//  ProfileView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 12/09/2023.
//

import SwiftUI
import Firebase
import UserNotifications

struct ProfileView: View {
    
    @State private var user: User? = nil
    @State private var enabledEdit: Bool = false
    
    @State private var isNameFocused: Bool = false
    @State private var isStreetFocused: Bool = false
    @State private var isCityFocused: Bool = false
    @State private var isCountryFocused: Bool = false
    @State private var isBioFocused: Bool = true
    
    @State private var showToast: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("background")
                        .resizable()
                        .frame(height: 250)
                    HStack {
                        ProfileImageView(image: "")
                            .offset(y: -55)
                            .padding(.bottom, -55)
                        if enabledEdit {
                            TextField("Name", text: Binding<String>(
                                get: { user?.name ?? "" },
                                set: { newValue in
                                    user?.name = newValue
                                }
                            ))
                            .fontWeight(.bold)
                            .font(.system(size: 28))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(isNameFocused ? Color.black : Color.gray, lineWidth: 2)
                                    .frame(height: 40)
                            )
                            .onTapGesture {
                                isNameFocused = true
                                isStreetFocused = false
                                isCityFocused = false
                                isCountryFocused = false
                                isBioFocused = false
                            }
                            
                        } else {
                            Text(user?.name ?? "")
                                .fontWeight(.bold)
                                .font(.system(size: 28))
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                        .frame(width:300, height: 1)
                        .padding(.horizontal, 10)
                        .background(.blue)
                        .opacity(0.75)
                    
                    HStack {
                        Text("Email: ")
                            .bold()
                        Text(user?.email ?? "")
                            .font(.system(size: 16))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("Street: ")
                            .bold()
                        
                        if enabledEdit {
                            TextField("Street", text: Binding<String>(
                                get: { user?.address.street ?? "" },
                                set: { newValue in
                                    user?.address.street = newValue
                                }
                            ))
                            .font(.system(size: 16))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(isStreetFocused ? Color.black : Color.gray, lineWidth: 2)
                                    .frame(height: 30)
                            )
                            .onTapGesture {
                                isNameFocused = false
                                isStreetFocused = true
                                isCityFocused = false
                                isCountryFocused = false
                                isBioFocused = false
                            }
                            
                        } else {
                            Text(user?.address.country ?? "")
                                .font(.system(size: 16))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("City: ")
                            .bold()
                        
                        if enabledEdit {
                            TextField("City", text: Binding<String>(
                                get: { user?.address.city ?? "" },
                                set: { newValue in
                                    user?.address.city = newValue
                                }
                            ))
                            .font(.system(size: 16))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(isCityFocused ? Color.black : Color.gray, lineWidth: 2)
                                    .frame(height: 30)
                            )
                            .onTapGesture {
                                isNameFocused = false
                                isStreetFocused = false
                                isCityFocused = true
                                isCountryFocused = false
                                isBioFocused = false
                            }
                        } else {
                            Text(user?.address.city ?? "")
                                .font(.system(size: 16))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("Country: ")
                            .bold()
                        
                        if enabledEdit {
                            TextField("Country", text: Binding<String>(
                                get: { user?.address.country ?? "" },
                                set: { newValue in
                                    user?.address.country = newValue
                                }
                            ))
                            .font(.system(size: 16))
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(isCountryFocused ? Color.black : Color.gray, lineWidth: 2)
                                    .frame(height: 30)
                            )
                            .onTapGesture {
                                isNameFocused = false
                                isStreetFocused = false
                                isCityFocused = false
                                isCountryFocused = true
                                isBioFocused = false
                            }
                        } else {
                            Text(user?.address.country ?? "")
                                .font(.system(size: 16))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    Divider()
                        .frame(width:300, height: 1)
                        .padding(.horizontal, 10)
                        .background(.blue)
                        .opacity(0.75)

                    Text("Bio:")
                    
                    if enabledEdit {
                        TextEditor(text: Binding<String>(
                            get: { user?.bio ?? "" },
                            set: { newValue in
                                user?.bio = newValue
                            }
                        ))
                        .font(.system(size: 16))
                        .padding()
                        .frame( height: 75)
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(isBioFocused ? Color.black : Color.gray, lineWidth: 2)
                                .frame(height: 75)
                                .padding()
                        )
                        .onTapGesture {
                            isNameFocused = false
                            isStreetFocused = false
                            isCityFocused = false
                            isCountryFocused = false
                            isBioFocused = true
                        }
                    } else {
                        Text(user?.bio ?? "")
                            .padding()
                            .lineSpacing(10)
                            .frame(height: 75)
                    }
                }
                
                
                HStack {
                    Spacer()
                    Button {
                        enabledEdit.toggle()
                        isNameFocused = false
                        isStreetFocused = false
                        isCityFocused = false
                        isCountryFocused = false
                        isBioFocused = false
                    } label: {
                        Text("Cancel")
                            .opacity(enabledEdit ? 1 : 0)
                    }
                    .padding()
                    
                    Button {
                        enabledEdit.toggle()
                        isNameFocused = false
                        isStreetFocused = false
                        isCityFocused = false
                        isCountryFocused = false
                        isBioFocused = false
                        
                        if enabledEdit == false {
                            if let user = user {
                                FireBaseDB().updateUser(user: user) { _ in
                                    showToast = true

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

            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                fetchUserData()
            }
            
            if showToast {
                VStack {
                    ToastView(message: "Updated!")
                    Spacer()
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




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
