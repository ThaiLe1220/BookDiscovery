import SwiftUI

struct SettingView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var userImage: UIImage = UIImage(named: "profile")!
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Divider()

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
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+4))
                                    .fontWeight(.semibold)
                                    .foregroundColor(userViewModel.isOn ? .white : .black)
                                
                                Text("\(userViewModel.currentUser.email)")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                                    .fontWeight(.light)
                                    .foregroundColor(userViewModel.isOn ? .white : .black)
                            }
                            .foregroundColor(Color(UIColor.darkGray))
                            Spacer()
                        }
                        .frame(height: 70)

                    }


                    settingRow(name: "Appearances", destination: UserAppearanceSettingView(userViewModel: userViewModel))

                    settingRow(name: "About", destination: UserAboutSettingView())
                }
                .listStyle(PlainListStyle())

                Spacer()
                Divider()

            }
            .padding(.top, 0)
            .background(Color(UIColor.secondarySystemBackground))
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Done") {
                    dismiss()
                }
                .foregroundColor(Color("OrangeMain"))
            )
        }
        .environment(\.colorScheme, userViewModel.isOn ? .dark : .light)
    }

    private func settingRow<V: View>(name: String, destination: V) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(name)
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                    .fontWeight(.regular)
                Spacer()
            }
        }
    }
}


struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(userViewModel: UserViewModel())
    }
}
