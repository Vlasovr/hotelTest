//
//  CurrencyFormatter.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//

import Foundation

struct CurrencyFormatter {
  static func format(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let number = NSNumber(value: amount)
        return formatter.string(from: number) ?? "\(Int(amount))"
    }
}
