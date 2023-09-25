/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 12/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/


// Import the Foundation library for basic Swift types and functionalities
import Foundation

// Define the Address struct which conforms to the Codable protocol
struct Address: Codable {
    // Properties of the Address struct
    
    var street: String  // Holds the street name
    var city: String    // Holds the city name
    var country: String // Holds the country name
}
