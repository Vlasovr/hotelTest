//
//  HotelNumbersView.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelNumbersView: View {
    
    private enum Constants {
        enum Layout {
            static let screenHeight = UIScreen.main.bounds.height
            static let minScreenHeigth: CGFloat = 800.0
            static let scaleEffect: CGFloat = 3
            static let cornerRadius: CGFloat = 12
        }
        
        enum Text {
            static let bg = "bg"
        }
    }
    
    @StateObject var viewModel: HotelNumbersViewModel
    
    var body: some View {
        HotelNumbersFlowCoordinator(state: viewModel, content: content)
            .overlay (
                bottomSafeAreaViewOverlay,
                alignment: .bottom
            )
    }
    
    private var bottomSafeAreaViewOverlay: some View {
        Group {
            if Constants.Layout.screenHeight > Constants.Layout.minScreenHeigth {
                BottomSafeAreaView()
            }
        }
    }
    
    @ViewBuilder private func content() -> some View {
        VStack {
            if viewModel.isDataLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(Constants.Layout.scaleEffect)
            } else {
                if let numbers = viewModel.hotelNumbers?.rooms {
                    ScrollView {
                        ForEach(0..<numbers.count, id: \.self) { index in
                            HotelNumberSection(viewModel: viewModel, number: numbers[index])
                                .cornerRadius(Constants.Layout.cornerRadius)
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .top) {
            InlineNavigatonBar(title: viewModel.hotelName) {
                viewModel.popView()
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .background(Color(Constants.Text.bg))
        .onAppear {
            viewModel.getHotelNumbersData()
        }
    }
}
