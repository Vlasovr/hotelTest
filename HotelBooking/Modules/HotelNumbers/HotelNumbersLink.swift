//
//  HotelNumberLink.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import Foundation

enum HotelNumbersLink: Hashable, Identifiable {
    case booking
    
    var id: String {
        String(describing: self)
    }
}
