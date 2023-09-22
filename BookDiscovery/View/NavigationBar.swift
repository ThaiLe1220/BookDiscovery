//
//  NavigationBar.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NavigationBar: View {
    @ObservedObject var userViewModel : UserViewModel

    var body: some View {
        ZStack {
            // Invisible view to detect taps
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        if userViewModel.isSearchBarVisible {
                            userViewModel.isSearchBarVisible = false
                        }
                    }
                }
            
            // Conditional Text Field
            HStack {
                TextField("Search", text: $userViewModel.searchText)
                    .frame(height: 34)
                    .padding(.horizontal, 36)
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                    .fontWeight(.regular)
                    .opacity(userViewModel.isSearchBarVisible ? 1 : 0)
                    .transition(.move(edge: .trailing))
                    .autocapitalization(.none)  // Disable automatic capitalization
                    .disableAutocorrection(true) // Disable autocorrection
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .foregroundColor(userViewModel.isOn ? .white : .black)
                    .tint(userViewModel.isSearchBarVisible ? Color("OrangeMain") : Color(UIColor.systemGray6))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(Color.white, lineWidth: 2)
//                            .overlay(
//                                Color(UIColor.clear)
//                            )
//                    }

                
                if userViewModel.isSearchBarVisible {
                    Button(action: {
                        userViewModel.searchText = ""
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(0.0)) {
                            userViewModel.isSearchBarVisible.toggle()
                            userViewModel.showSearch.toggle()
                        }
                    }) {
                        Text("Cancel")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                            .foregroundColor(Color("OrangeMain"))
                    }
                    .padding(.horizontal, 4)
                }
            }

            HStack (spacing: 0) {
                // This Spacer pushes the next elements to the right
                if !userViewModel.isSearchBarVisible {
                    Text("Search")
                        .padding(.horizontal, 36)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                        .foregroundColor(Color("GraySub"))

                    Spacer()
                }

                HStack {
                    Button(action: {
                        userViewModel.searchText = ""
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(0.0)) {
                            userViewModel.isSearchBarVisible.toggle()
                            userViewModel.showSearch.toggle()
                        }
                    }) {
                        Image(systemName: "text.magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(Color("GraySub"))
                    }
                    .padding(.horizontal, 4)

                    if userViewModel.isSearchBarVisible {
                        Spacer()
                        Button(action: {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(0.0)) {
                                userViewModel.isSearchBarVisible.toggle()
                                userViewModel.showSearch.toggle()
                            }
                        }) {
                            Text("Cancel")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.regular)
                                .foregroundColor(Color("OrangeMain"))
                        }
                        .padding(.horizontal, 4)
                    }

                }
            }
        }
        .padding(.horizontal, 8)
        .frame(width: UIScreen.main.bounds.width, height: 32)
        .onAppear {
            userViewModel.showSearch = false
            userViewModel.showSettings = false
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(userViewModel: UserViewModel())
    }
}
