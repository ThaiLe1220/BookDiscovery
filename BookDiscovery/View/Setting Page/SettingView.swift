import SwiftUI

struct SettingView: View {
    @Binding var isOn: Bool
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var userImage: UIImage = UIImage(named: "profile")!

    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                // Settings Options List
                List {
                    NavigationLink(destination: UserAccountSettingView(userViewModel: userViewModel)) {
                        HStack {
                            Text("")
                            ProfileImageView(userViewModel: userViewModel)
                                .scaleEffect(0.55)
                                .frame(width: 80, height: 80)
                            
                            VStack (alignment: .leading, spacing: 4) {
                                Text("\(userViewModel.currentUser.name)")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("\(userViewModel.currentUser.email)")
                                    .font(.system(size: 14, weight: .light))
                            }
                            .foregroundColor(Color(UIColor.darkGray))
                            Spacer()
                        }
                        .frame(height: 70)

                    }

                    settingRow(name: "Notifications", destination: UserNotificationSettingView())
                    settingRow(name: "Appearances", destination: UserAppearanceSettingView(isOn: $isOn, userViewModel: userViewModel))
                    settingRow(name: "Help & Support", destination: UserHelpSettingView())
                    settingRow(name: "About", destination: UserAboutSettingView())
                }
                .listStyle(PlainListStyle())

                Spacer()
            }
            .padding(.top, 45)
            .background(Color(UIColor.secondarySystemBackground))

            HStack {
                CustomBackButton(buttonColor: Color(UIColor.black), text: "Back")
                    .padding()
                Spacer()
            }
            .offset(y:-UIScreen.main.bounds.height*0.42)
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .onReceive(userViewModel.$showSettings) { showSettings in
            if !showSettings {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func settingRow<V: View>(name: String, destination: V) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(name)
                Spacer()
            }
        }
    }
}

struct UserNotificationSettingView: View {
    var body: some View {
        Text("User Notification Settings")
    }
}

struct UserHelpSettingView: View {
    var body: some View {
        Text("User Help & Support")
    }
}

struct UserAboutSettingView: View {
    var body: some View {
        Text("About the App")
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isOn: .constant(false), userViewModel: UserViewModel())
    }
}
