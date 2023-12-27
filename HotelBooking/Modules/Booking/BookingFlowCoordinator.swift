//
//  BookingFlowCoordinator.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

class BookingFlowState: ObservableObject {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
}

struct BookingFlowCoordinator<Content: View>: View {
    
    @ObservedObject var state: BookingFlowState
    let content: () -> Content
    
    var body: some View {
        content()
            .navigationDestination(for: BookingLink.self, destination: linkDestination)
    }
    
    @ViewBuilder private func linkDestination(link: BookingLink) -> some View {
        switch link {
        case .paymentSuccessed(let orderNumber):
            PaymentSuccessedView(viewModel: PaymentSuccessedViewModel(path: $state.path, orderNumber: orderNumber))
        }
    }
}
