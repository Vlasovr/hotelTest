//
//  HotelNumberFlowCoordinator.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

class HotelNumbersFlowState: ObservableObject {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
}

struct HotelNumbersFlowCoordinator<Content: View>: View {
    
    @ObservedObject var state: HotelNumbersFlowState
    let content: () -> Content
    
    var body: some View {
        content()
            .navigationDestination(for: HotelNumbersLink.self, destination: linkDestination)
    }
    
    @ViewBuilder private func linkDestination(link: HotelNumbersLink) -> some View {
        switch link {
        case .booking:
            BookingView(viewModel: BookingViewModel(path: $state.path))
        }
    }
}
