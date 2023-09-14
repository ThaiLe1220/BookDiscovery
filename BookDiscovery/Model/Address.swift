//
//  Address.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 12/09/2023.
//

// Import the Foundation library for basic Swift types and functionalities
import Foundation

// Define the Address struct which conforms to the Codable protocol
struct Address: Codable {
    // Properties of the Address struct
    
    var street: String  // Holds the street name
    var city: String    // Holds the city name
    var country: String // Holds the country name
}
