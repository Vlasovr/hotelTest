//
//  HotelView.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelView: View {
    private enum Constants {
        enum Layout {
            static let scaleEffect: CGFloat = 3
            static let cornerRadius: CGFloat = 12
            static let padding: CGFloat = 5
        }
        
        enum Text {
            static let chooseNumber = "К выбору номера"
            static let navButton = "navigationButton"
            static let bg = "bg"
        }
    }
    
    @StateObject var viewModel: HotelViewModel
    
    var body: some View {
        HotelFlowCoordinator(state: viewModel, content: content)
    }

    @ViewBuilder private func content() -> some View {
        VStack {
            if viewModel.isDataLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(Constants.Layout.scaleEffect)
            } else {
                if let hotel = viewModel.hotelData {
                    ScrollView {
                        HotelHeader(viewModel: viewModel) {
                            //there would be some action
                        }
                        .cornerRadius(Constants.Layout.cornerRadius)
                        Spacer()
                        HotelDescription(viewModel: viewModel)
                            .cornerRadius(Constants.Layout.cornerRadius)
                    }
                    NavigationButton(
                        title: Constants.Text.chooseNumber,
                        primaryColor: Color(Constants.Text.navButton),
                        secondaryColor: .white
                    ) {
                        viewModel.showHotelNumber()
                    }
                    .padding(.horizontal)
                    .padding(.top, Constants.Layout.padding)
                    .padding(.bottom, Constants.Layout.padding)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .scrollIndicators(.hidden)
        .background(Color(Constants.Text.bg))
        .onAppear {
            viewModel.getHotelData()
        }
    }
}

#Preview {
    HotelView(viewModel: HotelViewModel(networkService: NetworkService()))
}
