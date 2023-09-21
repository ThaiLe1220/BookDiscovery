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
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(height: 50)
                                    .opacity(0.9)
                                HStack {
                                    Text(bookViewModel.currentBook.name)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            }
                        }
                    }
                    
                    
                    HStack {
                        Button {
                            tabOverview = true
                            tabDetail = false
                            tabReview = false
                        } label: {
                            Text("Overview")
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
                                .foregroundColor(tabDetail ? (isOn ? .white : .black) : .gray)
                                .bold(tabDetail)
                                .padding(.horizontal)
                        }
                        Button {
                            tabOverview = false
                            tabDetail = false
                            tabReview = true
                        } label: {
                            Text("Reviews (\(reviewViewModel.reviews.count))")
                                .foregroundColor(tabReview ? (isOn ? .white : .black) : .gray)
                                .bold(tabReview)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    VStack {
                        if tabOverview {
                            HStack {
                                Text("Rating: ")
                                    .bold()
                                RatingView(rating: bookViewModel.currentBook.rating)
                                    .frame(width: 150)
                                Text(String(bookViewModel.currentBook.rating))
                                Spacer()
                            }
                            .padding(.leading)
                            HStack {
                                Text("Category: ")
                                    .padding(.horizontal)
                                    .bold()
                                Spacer()
                            }
                            HStack {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(bookViewModel.currentBook.category, id: \.self) { category in
                                            Text(category)
                                                .padding(5)
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
                                .padding(.bottom)
                            }
                            HStack {
                                Text("Author:")
                                    .padding(.horizontal)
                                    .bold()
                                Text(bookViewModel.currentBook.author.name)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Text(bookViewModel.currentBook.headline)
                                .padding()
                                .lineSpacing(15)
                        }
                        
                        if tabDetail {
                            Text((bookViewModel.currentBook.description))
                                .padding()
                                .lineSpacing(15)
                        }
                        
                        if tabReview {
                            VStack {
                                HStack {
                                    Text("Average: ")
                                        .padding(.leading, 30)
                                    Text(reviewViewModel.getAvg())
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    
                                    Spacer()
                                    
                                    Picker("Select an option", selection: $selectedOption) {
                                        ForEach(0...5, id: \.self) { index in
                                            if index == 0 {
                                                Text("All")
                                            } else {
                                                Text(String(repeating: "★", count: 6-index))
                                                    .font(.largeTitle)
                                            }
                                        }
                                    }
                                    .pickerStyle(DefaultPickerStyle())
                                    .padding()
                                }
                                HStack {
                                    LazyVStack() {
                                        VStack {
                                            ForEach(reviewViewModel.reviews, id: \.id) {
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
                        VStack {
                            Spacer()
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
                                            .bold()
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    bookViewModel.currentBook = currentBook
                    reviewViewModel.reviews = []
                    reviewViewModel.getReviews(bookID: currentBook.id)
                    for wishlistid in userViewModel.currentUser.wishlist {
                        if (currentBook.id == wishlistid) {
                            inWishList = true
                        }
                    }
                }
                
            }
            VStack {
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
            }
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        CustomBackButton(buttonColor: Color( isOn ? UIColor.white : UIColor.black), text: "Back")
                            .padding()
                    })
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isCommenting) {
            HStack {
                InputCommentView(bookID: bookViewModel.currentBook.id, currentBook: currentBook) { result in
                    if let review = result {
                        reviewViewModel.reviews.append(review)
                        
                        isCommenting = false
                    }
                }
                .padding()
            }.presentationDetents([.fraction(0.5)])
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), currentBook: emptyBook)
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
