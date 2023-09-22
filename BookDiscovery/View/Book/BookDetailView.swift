//
//  BookDetailView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var isOn: Bool
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
                        Color(.gray)
                            .opacity(0.2)
                        Image(uiImage: bookViewModel.currentBook.image!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    inWishList.toggle()
                                    wishlistToggle()
                                } label: {
                                    Image(systemName: inWishList ? "minus.square" : "plus.square")
                                        .foregroundColor(inWishList ? .red : .green)
                                        .padding()
                                        .font(.system(size: 25))
                                }
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                if inWishList {
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
                        Text(bookViewModel.currentBook.name)
                            .foregroundColor(.primary)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.bold)
                    }
                    
                    // View navigation (overview, detail, review)
                    HStack {
                        Button {
                            tabOverview = true
                            tabDetail = false
                            tabReview = false
                        } label: {
                            Text("Overview")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .foregroundColor(tabOverview ? (isOn ? .white : .black) : .gray)
                                .bold(tabOverview)
                                .padding(.horizontal)
                        }
                        Button {
                            tabOverview = false
                            tabDetail = true
                            tabReview = false
                        } label: {
                            Text("Book Details")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .foregroundColor(tabDetail ? (isOn ? .white : .black) : .gray)
                                .bold(tabDetail)
                                .padding(.horizontal)
                        }
                        Button {
                            tabOverview = false
                            tabDetail = false
                            tabReview = true
                        } label: {
                            Text("Reviews (\(reviewViewModel.currentBookReviews.count))")
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                .foregroundColor(tabReview ? (isOn ? .white : .black) : .gray)
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
                                Text("Rating: ")
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.bold)
                                    
                                RatingView(rating: bookViewModel.currentBook.rating)
                                
                                Text(String(bookViewModel.currentBook.rating))
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 2)

                            // Category View
                            VStack (alignment: .leading) {
                                Text("Category: ")
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.bold)
                                
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(bookViewModel.currentBook.category, id: \.self) { category in
                                            Text(category)
                                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                                .fontWeight(.regular)
                                                .padding(4)
                                                .background {
                                                    Rectangle()
                                                        .fill(Color.random())
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
                                Text("Author:")
                                    .padding(.horizontal)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.bold)
                                Text(bookViewModel.currentBook.author.name)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            
                            // Headline View
                            Text(bookViewModel.currentBook.headline)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                .fontWeight(.semibold)
                                .padding()
                                .lineSpacing(10)
                        }
                        
                        // Tab book detail logic
                        if tabDetail {
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
                                    Text("Average: ")
                                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                        .fontWeight(.regular)
                                        .padding(.leading, 30)
                                    Text(reviewViewModel.getAvg())
                                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                                        .fontWeight(.regular)
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    
                                    Spacer()
                                    
                                    Picker("Select an option", selection: $selectedOption) {
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
                                
                                HStack {
                                    LazyVStack() {
                                        VStack {
                                            ForEach(reviewViewModel.currentBookReviews, id: \.id) {
                                                review in
                                                HStack{
                                                    CommentView(isOn: $isOn, review: review, userViewModel: userViewModel)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .background(Color(UIColor.secondarySystemBackground))
                        }
                    }
                    
                    Spacer(minLength: 40)
                }

            }
            
            // Plus message for add review
            VStack {
                Divider()

                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        isCommenting = true
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
                
                VStack (spacing: 0) {
                    Button{
                        if let amazonURL = URLCaller(name: bookViewModel.currentBook.name).amazonURL() {
                            UIApplication.shared.open(amazonURL)
                        }
                    } label: {
                        if !tabReview {
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
            
            // Back button for navigation
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        CustomBackButton(userViewModel: userViewModel, buttonColor: Color( isOn ? UIColor.white : UIColor.black), text: "Back")
                            .padding()
                    })
                    Spacer()
                }
                Spacer()
            }
            
            
        }
        .onAppear {
            bookViewModel.currentBook = currentBook
            reviewViewModel.getReviewsByBook(bookID: currentBook.id)
            
            for id in userViewModel.currentUser.wishlist {
                currentBook.id == id ? inWishList = true : nil
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isCommenting) {
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

    func wishlistToggle() {
        if (inWishList) {
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
        BookDetailView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), currentBook: testBook)
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
