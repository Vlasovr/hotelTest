//
//  HotelNumberDescription.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelNumberDescription: View {
    private enum Constants {
        enum Layout {
            static let aboutHotelFontSize: CGFloat = 22
            static let trailingPadding: CGFloat = 5
            static let cornerRadius: CGFloat = 5
            static let priceFontSize: CGFloat = 30
            static let pricePerFontSize: CGFloat = 16
            static let descriptionOpacity: CGFloat = 0.9
            static let horizontalPadding: CGFloat  = 10
            static let topPadding: CGFloat  = 10
        }
        
        enum Text {
            static let textGray = "textGray"
            static let bg = "bg"
        }
    }
    
    var number: Number
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(number.name)
                    .font(.system(size: Constants.Layout.aboutHotelFontSize, weight: .medium))
                ForEach(0..<number.peculiarities.count, id: \.self) { rowIndex in
                    HStack(alignment: .top) {
                        ForEach(0..<2, id: \.self) { columnIndex in
                            let index = rowIndex * 2 + columnIndex
                            if index < number.peculiarities.count {
                                hotelOption(title: number.peculiarities[index])
                                    .padding(.trailing, Constants.Layout.trailingPadding)
                                    .cornerRadius(Constants.Layout.cornerRadius)
                            }
                            
                        }
                    }
                }
                MoreAboutNumber {}
                HStack {
                    Text("\(number.price) ₽")
                        .font(.system(size: Constants.Layout.priceFontSize, weight: .semibold))
                    Text(number.pricePer.lowercased())
                        .font(.system(size: Constants.Layout.pricePerFontSize, weight: .regular))
                        .foregroundColor(Color(Constants.Text.textGray))
                        .padding(.top, Constants.Layout.topPadding)
                }
            }
        }
    }
    
    @ViewBuilder func hotelOption(title: String) -> some View {
        Text(title)
            .font(.system(size: Constants.Layout.pricePerFontSize, weight: .medium))
            .foregroundColor(Color(Constants.Text.textGray))
            .padding(.horizontal, Constants.Layout.horizontalPadding)
            .padding(.vertical, Constants.Layout.trailingPadding)
            .background(Color(Constants.Text.bg))
    }
}
