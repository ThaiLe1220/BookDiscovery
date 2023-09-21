//
//  NotificationsView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var isOn: Bool

    @ObservedObject var userViewModel : UserViewModel

    var body: some View {
        NavigationStack {
            VStack {
//                NavigationBar(userViewModel: userViewModel)
                Text("Notifications View")
                Spacer()
                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(isOn: .constant(false), userViewModel: UserViewModel())
    }
}
