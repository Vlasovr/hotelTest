//
//  PaymentSuccessedViewModel.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI
import Combine

final class PaymentSuccessedViewModel: PaymentSuccessedFlowState {
    
    var orderNumber: String
    
    init(path: Binding<NavigationPath>,
         orderNumber: String
    ) {
        self.orderNumber = orderNumber
        super.init(path: path)
    }
    func popView() {
        path.removeLast()
    }
    
    func goToHotel() {
        path = .init()
    }
}
