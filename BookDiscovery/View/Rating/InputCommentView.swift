/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 15/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI
import Firebase
// InputCommentView struct for inputting reviews about books

struct InputCommentView: View {
    // Observing User and Review ViewModels

    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    // Identifier of the current book being reviewed
    var bookID: String
    
    // Information about the current book
    var currentBook: Book
    @State private var content: String = ""     // State variables
    @State private var numStar: Int = 0
    @State private var announcement: String = ""
    @State private var isError: Bool = true
    
    
    var completion: (Review?) -> Void    // Completion handler for the review process

    var body: some View {
        VStack {         // Main vertical stack for the view

            VStack{             // Header section

                HStack{
                    Rectangle() // This is for the designer of a gray line on top
                        .fill(.gray)
                        .frame(width: 70, height: 5)
                        .cornerRadius(2)
                }
                Divider()
            }
            
            VStack {
                Spacer()
                VStack {
                    // This is then dis play the Book Name on the Left
                    HStack {
                        Text(currentBook.name)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                        Spacer()
                        // And then the rating for user to pick on the right
                        ForEach(1..<6) { i in
                            Image(systemName: numStar >= i  ? "star.fill" : "star")
                                .foregroundColor(numStar >= i ? .yellow : .gray)
                                .gesture(
                                    TapGesture(count: 1)
                                        .onEnded { _ in
                                            announcement = ""
                                            if numStar == i {
                                                numStar = 0
                                            } else {
                                                numStar = i
                                            }
                                        }
                                )
                        }
                    }
                    // Then display the author's name under the Book Name
                    HStack {
                        Text(currentBook.author)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                            .fontWeight(.light)
                            .italic()
                        Spacer()
                    }
                    // This is a simple text for user to know what to write in the textEditor
                    HStack {
                        Text("Write down your experience below:")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                        Spacer()
                    }
                }
                Spacer()
                TextEditor(text: $content)                // Text editor for the review content, user can type freely in this box
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+4))
                    .fontWeight(.regular)
                    .frame(minHeight: 100)
                    .border(.gray, width: 1)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: content) { newValue in
                        announcement = ""
                    }
                
                HStack { // We dont do anything with this one, but to test with something
                    Text(announcement)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .foregroundColor(isError ? .red : .green)
                    
                    Spacer()
                    // Send button to submit the review
                    Button {
                        if numStar == 0 || content == "" {                         // Validation and Firebase submission logic

                            announcement = "Invalid!"
                            isError = true
                            return
                        }
                        
                        if let userID = Auth.auth().currentUser?.uid { // This is used to check with FireBase whether this account is exists, if exists, then addReview to database
                            FireBaseDB().addReview(userID: userID, bookID: bookID, rating: Double(numStar), comment: content) { success in
                                if let review = success { // First, add the data into Firebase, then save them into ReviewViewModel then to this appState to display on FrontEnd
                                    content = ""
                                    numStar = 0
                                    announcement = "Successful!"
                                    isError = false
                                    completion(review)
                                    reviewViewModel.currentBookReviews.append(review)
                                    reviewViewModel.allReviews.append(review)
                                } else {
                                    completion(nil)
                                }
                            }
                        }
                        

                    } label: {
                        Text("Send")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular) // This is how the button would loook like
                    }
                }
            }
        }
    }
}
