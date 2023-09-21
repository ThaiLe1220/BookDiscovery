import SwiftUI

struct SettingView: View {
    @Binding var isOn: Bool
    @ObservedObject var userViewModel: UserViewModel
    @State private var userImage: UIImage = UIImage(named: "profile")!

    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Divider()

                // Settings Options List
                List {
                    NavigationLink(destination: UserAccountSettingView(isOn: $isOn, userViewModel: userViewModel)) {
                        HStack {
                            Text("")
                            ProfileImageView(isOn: $isOn, userViewModel: userViewModel)
                                .scaleEffect(0.55)
                                .frame(width: 80, height: 80)
                            
                            VStack (alignment: .leading, spacing: 4) {
                                Text("\(userViewModel.currentUser.name)")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(isOn ? .white : .black)
                                
                                Text("\(userViewModel.currentUser.email)")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(isOn ? .white : .black)
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
                Divider()

            }
            .padding(.top, 45)
            .background(Color(UIColor.secondarySystemBackground))

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
