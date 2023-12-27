//
//  DetailedBookingInfo.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//

import SwiftUI

struct DetailedBookingInfo: View {
    
    private enum Constants {
        enum Layout {
            static let labelWidth: CGFloat = 140
            static let topPadding: CGFloat = 8
            static let fontSize: CGFloat = 16
            static let verticalPadding: CGFloat = 10
            static let bottomPadding: CGFloat = 10
        }
        
        enum Text {
            static let flyFrom = "Вылет из"
            static let textGray = "textGray"
            static let place = "Страна, город"
            static let dates = "Даты"
            static let nightQuantity = "Кол-во ночей"
            static let nights = "ночей"
            static let hotel = "Отель"
            static let number = "Номер"
            static let eating = "Питание"
        }
    }
    
    var hotel: HotelBooking

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(Constants.Text.flyFrom)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text(hotel.departure)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.place)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text(hotel.arrivalCountry)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.dates)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text("\(hotel.tourDateStart) - \(hotel.tourDateStop)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.nightQuantity)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text("\(hotel.numberOfNights) " + Constants.Text.nights)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.hotel)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text(hotel.hotelName)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.number)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text(hotel.room)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.eating)
                    .frame(width: Constants.Layout.labelWidth, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text(hotel.nutrition)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Constants.Layout.topPadding)
        }
        .font(.system(size: Constants.Layout.fontSize, weight: .regular))
        .padding(.horizontal)
        .padding(.vertical, Constants.Layout.verticalPadding)
        .padding(.bottom, Constants.Layout.bottomPadding)
        .background(.white)
    }
}
