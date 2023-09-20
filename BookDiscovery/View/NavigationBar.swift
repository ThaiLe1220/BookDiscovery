//
//  NavigationBar.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NavigationBar: View {
    @ObservedObject var userViewModel : UserViewModel
    var performSearch: () -> Void
    @State var isSearchBarVisible: Bool = false

    var body: some View {
        ZStack {
            // Invisible view to detect taps
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        if isSearchBarVisible {
                            isSearchBarVisible = false
                        }
                    }
                }
            
            // Conditional Text Field
            TextField("", text: $userViewModel.searchText, onCommit: performSearch)
                .frame(height: 30)
                .padding(.horizontal, 35)
                .background(Color(UIColor.lightText))
                .cornerRadius(20)
                .foregroundColor(.gray)
//                .animation(Animation.easeInOut(duration: 0.5), value: isSearchBarVisible)
                .opacity(isSearchBarVisible ? 1 : 0)
                .transition(.move(edge: .trailing))
                .autocapitalization(.none)  // Disable automatic capitalization
                .disableAutocorrection(true) // Disable autocorrection

            HStack (spacing: 0) {
                // This Spacer pushes the next elements to the right
                if !isSearchBarVisible {
                    Spacer()
                }

                HStack {
                    Button(action: {
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(0.0)) {
                            isSearchBarVisible.toggle()
                        }
                    }) {
                        Image(systemName: "text.magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(Color("OrangeMain"))
                    }
                    .padding(.horizontal, 4)

                    if isSearchBarVisible {
                        Spacer()
                    }
                }
                
                if !isSearchBarVisible {
                    Button(action: {
                        userViewModel.showSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 24))
                            .foregroundColor(Color("OrangeMain"))
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .frame(width: UIScreen.main.bounds.width, height: 40)
        .padding(.bottom, 4)
        .onAppear {
            userViewModel.showSearch = false
            userViewModel.showSettings = false
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(userViewModel: UserViewModel(), performSearch: {})
    }
}
