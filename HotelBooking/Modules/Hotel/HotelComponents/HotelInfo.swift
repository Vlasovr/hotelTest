//
//  HotelInfo.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelInfo: View {
    private enum Constants {
        enum Layout {
            static let opacity: CGFloat = 0.2
            static let leadingPadding: CGFloat = 5
            static let horizontal: CGFloat = 10
            static let cornerRadius: CGFloat = 10
            static let nameFontSize: CGFloat = 22
            static let locationFontSize: CGFloat = 22
        }
        
        enum Text {
            static let starIcon = "starIcon"
            static let textGold = "textGold"
            static let gold = "gold"
        }
    }
    var rating: String
    var hotelName: String
    var hotelLocation: String
    
    let action: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(Constants.Text.starIcon)
                Text(rating)
                    .foregroundColor(Color(Constants.Text.textGold))
                    .padding(.leading, -Constants.Layout.leadingPadding)
            }
            .padding(.horizontal, Constants.Layout.horizontal)
            .padding(.vertical, Constants.Layout.leadingPadding)
            .background(Color(Constants.Text.gold).opacity(Constants.Layout.opacity))
            .cornerRadius(Constants.Layout.cornerRadius)
            Spacer()
            Text(hotelName)
                .font(.system(size: Constants.Layout.nameFontSize, weight: .medium))
            Spacer()
            Button {
                action()
            } label: {
                Text(hotelLocation)
                    .font(.system(size: Constants.Layout.locationFontSize, weight: .medium))
            }
        }
    }
}

#Preview {
    HotelView(viewModel: HotelViewModel(networkService: NetworkService()))
}
