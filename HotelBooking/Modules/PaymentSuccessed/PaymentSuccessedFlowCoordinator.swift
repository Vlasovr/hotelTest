//
//  PaymentSuccessedFlowCoordinator.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

class PaymentSuccessedFlowState: ObservableObject {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
}

struct PaymentSuccessedFlowCoordinator<Content: View>: View {
    
    @ObservedObject var state: PaymentSuccessedFlowState
    let content: () -> Content
    
    var body: some View {
        content()
            .navigationDestination(for: PaymentSuccessedLink.self, destination: linkDestination)
    }
    
    @ViewBuilder private func linkDestination(link: PaymentSuccessedLink) -> some View {
        switch link {
        case .some:
            Text("Some future case")
        }
    }
}
