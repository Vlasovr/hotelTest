//
//  PaymentSuccessedLink.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import Foundation

enum PaymentSuccessedLink: Hashable, Identifiable {
    case some
    
    var id: String {
        String(describing: self)
    }
}
