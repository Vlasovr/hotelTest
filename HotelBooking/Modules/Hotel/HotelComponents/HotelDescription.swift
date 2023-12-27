//
//  HotelDescription.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct HotelDescription: View {
    private enum Constants {
        enum Layout {
            static let aboutHotelFontSize: CGFloat = 22
            static let trailingPadding: CGFloat = 5
            static let cornerRadius: CGFloat = 5
            static let descriptionFontSize: CGFloat = 16
            static let descriptionOpacity: CGFloat = 0.9
            static let sectionCornerRadius: CGFloat = 15
            static let sectionHeight: CGFloat = 200
            static let hotelOptionFontSize: CGFloat = 16
            static let hotelOptionHorizontalPadding: CGFloat = 10
            static let hotelOptionVerticalPadding: CGFloat = 5
        }
        
        enum Text {
            static let aboutHotel = "Об отеле"
            static let textGray = "textGray"
            static let bg = "bg"
            static let happy = "happy"
            static let tick = "tick"
            static let close = "close"
            static let comforts = "Удобства"
            static let nessesary = "Самое необходимое"
            static let whatsOn = "Что включено"
            static let whatsOff = "Что не включено"
        }
    }
    
    @StateObject var viewModel: HotelViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Spacer()
            Text(Constants.Text.aboutHotel)
                .font(.system(size: Constants.Layout.aboutHotelFontSize, weight: .medium))
            Spacer()
            Spacer()
            VStack(alignment: .leading) {
                
                ForEach(0..<viewModel.peculiaritiesRowsCount, id: \.self) { rowIndex in
                    HStack(alignment: .top) {
                        ForEach(0..<2, id: \.self) { columnIndex in
                            let index = rowIndex * 2 + columnIndex
                            if index < viewModel.hotelData?.aboutTheHotel.peculiarities.count ?? HotelViewModel.Defaults.description.count {
                                if let option = viewModel.hotelData?.aboutTheHotel.peculiarities[index] {
                                    hotelOption(title: option)
                                        .padding(.trailing, Constants.Layout.trailingPadding)
                                        .cornerRadius(Constants.Layout.cornerRadius)
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
            Spacer()
            Text(viewModel.hotelData?.aboutTheHotel.description ?? HotelViewModel.Defaults.description)
                .font(.system(size: Constants.Layout.descriptionFontSize, weight: .regular))
                .opacity(Constants.Layout.descriptionOpacity)
            Spacer()
            Spacer()
            
            List {
                MoreInfoSection(
                    imageName: Constants.Text.happy,
                    headerTitle: Constants.Text.comforts,
                    title: Constants.Text.nessesary
                ) {
                    //there would be navigation action
                }
                MoreInfoSection(
                    imageName: Constants.Text.tick,
                    headerTitle: Constants.Text.whatsOn,
                    title: Constants.Text.nessesary
                ) {
                    //there would be navigation action
                }
                MoreInfoSection(
                    imageName: Constants.Text.close,
                    headerTitle: Constants.Text.whatsOff,
                    title: Constants.Text.nessesary
                ) {
                    //there would be navigation action
                }
            }
            .cornerRadius(Constants.Layout.sectionCornerRadius)
            .listStyle(PlainListStyle())
            .frame(height: Constants.Layout.sectionHeight)
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            Spacer()
        }
        .padding(.horizontal)
        .background(.white)
    }
    
    @ViewBuilder func hotelOption(title: String) -> some View {
        Text(title)
            .font(.system(size: Constants.Layout.hotelOptionFontSize, weight: .medium))
            .foregroundColor(Color(Constants.Text.textGray))
            .padding(.horizontal, Constants.Layout.hotelOptionHorizontalPadding)
            .padding(.vertical, Constants.Layout.hotelOptionVerticalPadding)
            .background(Color(Constants.Text.bg))
    }
}
