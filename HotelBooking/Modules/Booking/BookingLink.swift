//
//  BookingLink.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import Foundation

enum BookingLink: Hashable, Identifiable {
    case paymentSuccessed(orderNumber: String)
    
    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: BookingLink, rhs: BookingLink) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
