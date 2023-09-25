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

struct BookDetailView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    var currentBook: Book
    
    @State var inWishList: Bool = false
    
    
    @State private var tabOverview: Bool = true
    @State private var tabDetail: Bool = false
    @State private var tabReview: Bool = false
    
    @State private var selectedOption = 0
    @State private var isCommenting:Bool = false
    
    @Environment (\.dismiss) var  dismiss

    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    // Book Image
                    ZStack {
                        Color(.gray)    // Background color with opacity

                            .opacity(0.2)
                        Image(uiImage: bookViewModel.currentBook.image!)    // Display the book image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button {            // Button to toggle wishlist status
                                    inWishList.toggle()
                                    wishlistToggle()
                                } label: {
                                    Image(systemName: inWishList ? "minus.square" : "plus.square") // if not in wishList, display '+', if its in, display '-'
                                        .foregroundColor(inWishList ? .red : .green)
                                        .padding()
                                        .font(.system(size: 25))
                                }
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                if inWishList { // This is to display if user has already added the book into wishlist
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 20))
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    
                    // Book Name
                    HStack {
                        Text(bookViewModel.currentBook.name) // Next, this is to display the book name first
                            .foregroundColor(.primary)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.bold)
                    }
                    
                    // View navigation (overview, detail, review)
                    HStack {
                        Button {
                            tabOverview = true // This is the initialization for the app, previously display the tab Overview
                            tabDetail = false
                            tabReview = false
                        } label: {
                            Text("Overview") // Display Overview
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .foregroundColor(tabOverview ? (userViewModel.isOn ? .white : .black) : .gray)
                                .bold(tabOverview)
                                .padding(.horizontal)
                        }
                        Button {
                            tabOverview = false
                            tabDetail = true // Next , if user select tabDetails, display TabDetails under
                            tabReview = false
                        } label: {
                            Text("Book Details")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .foregroundColor(tabDetail ? (userViewModel.isOn ? .white : .black) : .gray)
                                .bold(tabDetail)
                                .padding(.horizontal)
                        }
                        Button {
                            tabOverview = false
                            tabDetail = false
                            tabReview = true // then lastly, iuf user slect tabReview, dipslay TabReiview under
                        } label: {
                            Text("Reviews (\(reviewViewModel.currentBookReviews.count))")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .foregroundColor(tabReview ? (userViewModel.isOn ? .white : .black) : .gray)
                                .bold(tabReview)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    // Tab overview, detail, review content
                    VStack {
                        // Tab overview logic
                        if tabOverview {
                            // Rating View
                            HStack {
                                Text("Rating: ") // Display Rating text
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.bold)
                                    
                                RatingView(rating: bookViewModel.currentBook.rating) // Display Rating View for the Book
                                
                                Text(String(bookViewModel.currentBook.rating)) // On the right of the stars, display the rating in numbers
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 2)

                            // Category View
                            VStack (alignment: .leading) {
                                Text("Category: ") // Under the rating, display the Category, first is the text
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.bold)
                                
                                ScrollView(.horizontal) {
                                    HStack {// For the scroll view in horizontal, display the the category of the book in lists by using ForEach,
                                        ForEach(bookViewModel.currentBook.category, id: \.self) { category in
                                            Text(category) // In the loop, display the category text
                                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                                .fontWeight(.regular)
                                                .padding(4)
                                                .background {
                                                    Rectangle()
                                                        .fill(Color.random()) //This is for the background color of the category that will be generated random
                                                        .cornerRadius(5)
                                                }
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .padding(.horizontal)
                            }
                            
                            // Author View
                            HStack (spacing: 0) {
                                Text("Author:") // Next, display the author of the app, first is the text author
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.bold)
                                Text(bookViewModel.currentBook.author) // then the author's name
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            
                            // Headline View
                            Text(bookViewModel.currentBook.headline) // Next, this is to display the headline of the book
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                .fontWeight(.semibold)
                                .padding()
                                .lineSpacing(10)
                        }
                        
                        // Tab book detail logic
                        if tabDetail {
                            // This one is simple, this is to display the bookView Description in this tab
                            Text((bookViewModel.currentBook.description))
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .fontWeight(.regular)
                                .padding()
                                .lineSpacing(10)
                        }
                        
                        // Tab book review logic
                        if tabReview {
                            VStack {
                                HStack {
                                    Text("Average: ") // This is to display the average text
                                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                        .fontWeight(.regular)
                                        .padding(.leading, 30)
                                    Text(reviewViewModel.getAvg()) // then on the right of it, display the rating in numbers
                                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                        .fontWeight(.regular)
                                    
                                    Image(systemName: "star.fill") // display the stars
                                        .foregroundColor(.yellow)
                                    
                                    Spacer()
                                    
                                    Picker("Select an option", selection: $selectedOption) { // Select an option to displya based on the star selected
                                        ForEach(0...5, id: \.self) { index in
                                            if index == 0 {
                                                Text("All")
                                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                                    .fontWeight(.regular)
                                            } else {
                                                Text(String(repeating: "★", count: 6-index))
                                                    .font(.largeTitle)
                                            }
                                        }
                                    }
                                    .pickerStyle(DefaultPickerStyle())
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.regular)
                                    .padding()
                                }
                                
                                // This part is to collect the Review data from the FIrebase, then display them into this tab
                                HStack {
                                    LazyVStack() {
                                        VStack {
                                            ForEach(reviewViewModel.currentBookReviews, id: \.id) {
                                                review in
                                                HStack{
                                                    CommentView(review: review, userViewModel: userViewModel) // Input the data review for CommentView to generate images
                                                }
                                            }
                                        }
                                        .padding(8)
                                    }
                                }
                            }
                            .background(Color(UIColor.secondarySystemBackground))
                        }
                    }
                    
                    Spacer(minLength: 40)
                }

            }
            .scrollIndicators(.hidden)

            // Plus message for add review
            VStack {
                Divider()

                Spacer()
                
                /*
                 This parts handle the Add new Review function
                 */
                HStack {
                    Spacer()
                    Button(action: {
                        isCommenting = true // Toggle to display comment tab
                    }, label: {
                        Image(systemName: "plus.message.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                            .padding(.trailing)
                            .background(
                                Image(systemName: "plus.message")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                            )

                    })
                }
                
                VStack (spacing: 0) { // This is to get the link of the book to amazon Search
                    Button{
                        if let amazonURL = URLCaller(name: bookViewModel.currentBook.name).amazonURL() {
                            UIApplication.shared.open(amazonURL)
                        }
                    } label: {
                        if !tabReview { //If it is not in Review Comment Tab, display the button to buy the book
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color("Amazon-Orange"))
                                    .frame(height: 50)
                                Text("Buy On Amazon")
                                    .foregroundColor(.black)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    
                    Divider()
                }

            }
            .offset(y: -20)
            
            // Back button for navigation
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        CustomBackButton(userViewModel: userViewModel, buttonColor: Color(userViewModel.isOn ? UIColor.white : UIColor.black), text: "Back")
                            .padding()
                    })
                    Spacer()
                }
                Spacer()
            }
            
            
        }
        .onAppear {
            bookViewModel.currentBook = currentBook // get the current book from the bookViewModel
            reviewViewModel.getReviewsByBook(bookID: currentBook.id)
            
            for id in userViewModel.currentUser.wishlist { // Check if wishlist has this book in the system
                currentBook.id == id ? inWishList = true : nil
            }
            print(bookViewModel.currentBook)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isCommenting) { // This is to display the inputCommentView
            HStack {
                InputCommentView(userViewModel: userViewModel, reviewViewModel: reviewViewModel, bookID: bookViewModel.currentBook.id, currentBook: currentBook) { result in
                    if let review = result {
                        isCommenting = false
                    }
                }
                .padding()
            }
            .presentationDetents([.fraction(0.5)])
        }
    }

    func wishlistToggle() { // This one handles the WishList
        if (inWishList) { // if the Wishlist
            userViewModel.currentUser.wishlist.append(currentBook.id)
            FireBaseDB().updateUser(user: userViewModel.currentUser) { (success, error) in
                if success {
                    print("User updated data successfully")
                } else {
                    print (error?.localizedDescription ?? "Unknown error")
                }
            }
        }
        else {
            if let index = userViewModel.currentUser.wishlist.firstIndex(of: currentBook.id) {
                userViewModel.currentUser.wishlist.remove(at: index)
            }
            FireBaseDB().updateUser(user: userViewModel.currentUser) { (success, error) in
                if success {
                    print("User updated data successfully")
                } else {
                    print (error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }
    
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), currentBook: testBook)
    }
}


extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0.5...1)
        let green = Double.random(in: 0.5...1)
        let blue = Double.random(in: 0.5...1)
        return Color(red: red, green: green, blue: blue)
    }
}
