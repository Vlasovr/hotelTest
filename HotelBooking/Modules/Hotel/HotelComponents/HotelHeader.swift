//
//  HotelHeader.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelHeader: View {
    private enum Constants {
        enum Layout {
            static let titleFontSize: CGFloat = 12
            static let topPadding: CGFloat = 10
            static let leadingPadding: CGFloat = 15
            static let cornerRadius: CGFloat = 10
            static let opacity: CGFloat = 0.15
            static let hotelSize: CGFloat = 18
            static let hotelImageHeight: CGFloat = 257
            static let hotelImageCornerRadius: CGFloat = 15
            static let minimalPriceFontSize: CGFloat = 30
            static let priceForItFontSize: CGFloat = 16
            static let priceForItPadding: CGFloat = 8
            static let safeAreaPadding: CGFloat = 50
        }
        
        enum Text {
            static let hotel = "Отель"
            static let textGray = "textGray"
        }
    }
    
    @StateObject var viewModel: HotelViewModel
    @State var currentIndex = 0
    let action: () -> Void
    
    var body: some View {
        
        VStack {
            Text(Constants.Text.hotel)
                .font(.system(size: Constants.Layout.hotelSize, weight: .medium))
            TabView(selection: $currentIndex) {
                ForEach(viewModel.hotelImages.indices, id: \.self) { index in
                    Image(uiImage: viewModel.hotelImages[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                        .frame(height: Constants.Layout.hotelImageHeight)
                        .cornerRadius(Constants.Layout.cornerRadius)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: Constants.Layout.hotelImageHeight)
            .cornerRadius(Constants.Layout.cornerRadius)
            .overlay(alignment: .bottom) {
                ImageControl(currentIndex: $currentIndex, total: viewModel.hotelImages.count, visibleIndicators: 5)
                
            }
            VStack(alignment: .leading) {
                if let hotel = viewModel.hotelData {
                    HotelInfo(
                        rating: "\(hotel.rating) " + hotel.ratingName,
                        hotelName: hotel.name,
                        hotelLocation: hotel.adress) {
                            action()
                        }
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    HStack {
                        Text("от \(hotel.minimalPrice) ₽")
                            .font(.system(size: Constants.Layout.minimalPriceFontSize, weight: .semibold))
                        Text(hotel.priceForIt.lowercased())
                            .font(.system(size: Constants.Layout.priceForItFontSize, weight: .regular))
                            .foregroundColor(Color(Constants.Text.textGray))
                            .padding(.top, Constants.Layout.priceForItPadding)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .safeAreaPadding(.top, Constants.Layout.safeAreaPadding)
        .padding(.horizontal)
        .background(.white)
    }
}
#Preview {
    HotelView(viewModel: HotelViewModel(networkService: NetworkService()))
}
