import SwiftUI

struct SettingView: View {
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Settings Options List
                List {
                   settingRow(name: "Account", destination: UserAccountSettingView())
                   settingRow(name: "Notifications", destination: UserNotificationSettingView())
                   settingRow(name: "Appearances", destination: UserAppearanceSettingView())
                   settingRow(name: "Help & Support", destination: UserHelpSettingView())
                   settingRow(name: "About", destination: UserAboutSettingView())
                }
                .padding(.top, 10)
                .listStyle(InsetGroupedListStyle())

                Spacer()
                
                // Logout Button
                Button(action: {
                   print("Logout tapped!")
                }) {
                   Text("Logout")
                       .foregroundColor(.red)
                }
                .padding(.bottom, 20)
            }
            .background(Color(UIColor.secondarySystemBackground))
        }
            .navigationBarItems(leading: EmptyView()) // Remove any leading navigation items
//            .navigationBarBackButtonHidden(true) // Hide the default back button
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

// Dummy Views, replace these with your actual implementations
struct UserAccountSettingView: View {
    var body: some View {
        Text("User Account Settings")
    }
}

struct UserNotificationSettingView: View {
    var body: some View {
        Text("User Notification Settings")
    }
}

struct UserAppearanceSettingView: View {
    var body: some View {
        Text("User Appearance Settings")
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
        SettingView(userViewModel: UserViewModel())
    }
}
