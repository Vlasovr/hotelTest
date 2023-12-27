//
//  HotelLink.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

enum HotelLink: Hashable, Identifiable {
    case hotelNumber(hotelName: String)
    
    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: HotelLink, rhs: HotelLink) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
