//
//  HotelBookingApp.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

@main
struct HotelBookingApp: App {
    var body: some Scene {
        WindowGroup {
            HotelView(viewModel: HotelViewModel())
        }
    }
}
