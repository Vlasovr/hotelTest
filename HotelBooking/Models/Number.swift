//
//  Number.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import UIKit

struct Number: Codable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]

    var images: [UIImage]? = nil
    
    enum CodingKeys: String, CodingKey {
        case id, name, price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}
