//
//  HotelFlowCoordinator.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

class HotelFlowState: ObservableObject {
    @Published var path = NavigationPath()
}

struct HotelFlowCoordinator<Content: View>: View {
    
    @ObservedObject var state: HotelFlowState
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
            }
            .navigationDestination(for: HotelLink.self, destination: linkDestination)
        }
    }
    
    @ViewBuilder private func linkDestination(link: HotelLink) -> some View {
        switch link {
        case .hotelNumber(let hotelName):
            HotelNumbersView(viewModel: HotelNumbersViewModel(
                path: $state.path,
                networkService: NetworkService(),
                hotelName: hotelName
            ))
        }
    }
}
