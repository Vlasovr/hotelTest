//
//  HotelMainInfoHeader.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelMainInfoHeader: View {
    
    private enum Constants {
        enum Layout {
            static let spacerLength: CGFloat = 16
            static let leadingPadding: CGFloat = 5
            static let horizontalPadding: CGFloat = 10
            static let opacity: CGFloat = 0.2
            static let cornerRadius: CGFloat = 5
            static let nameFontSize: CGFloat = 22
            static let addressFontSize: CGFloat = 14
        }
        
        enum Text {
            static let gold = "gold"
            static let starIcon = "starIcon"
            static let textGold = "textGold"
        }
    }
    
    var hotel: HotelBooking
    
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: Constants.Layout.spacerLength)
            HStack {
                Image(Constants.Text.starIcon)
                Text("\(hotel.horating) " + hotel.ratingName)
                    .foregroundColor(Color(Constants.Text.textGold))
                    .padding(.leading, -Constants.Layout.leadingPadding)
            }
            .padding(.horizontal, Constants.Layout.horizontalPadding)
            .padding(.vertical, Constants.Layout.leadingPadding)
            .background(Color(Constants.Text.gold).opacity(Constants.Layout.opacity))
            .cornerRadius(Constants.Layout.cornerRadius)
            Text(hotel.hotelName)
                .font(.system(size: Constants.Layout.nameFontSize, weight: .medium))
            Button {
                action()
            } label: {
                Text(hotel.hotelAdress)
                    .font(.system(size: Constants.Layout.addressFontSize, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: Constants.Layout.spacerLength)
        }
        .padding(.horizontal)
        .background(.white)
    }
}
