//
//  PaymentView.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//
import SwiftUI

struct PaymentView: View {
    private enum Constants {
        enum Layout {
            static let topPadding: CGFloat = 8
            static let fontSize: CGFloat = 16
            static let verticalPadding: CGFloat = 10
            static let bottomPadding: CGFloat = 10
        }
        
        enum Text {
            static let tour = "Тур"
            static let textGray = "textGray"
            static let fuelCharge = "Топливный сбор"
            static let navButton = "navigationButton"
            static let serviceCharge = "Сервисный сбор"
            static let totalAmount = "К оплате"
            static let rubleSign = "₽"
        }
    }
    
    let hotel: HotelBooking

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(Constants.Text.tour)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text("\(hotel.tourPrice) " + Constants.Text.rubleSign)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.fuelCharge)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text("\(hotel.fuelCharge) " + Constants.Text.rubleSign)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.serviceCharge)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                Text("\(hotel.serviceCharge) " + Constants.Text.rubleSign)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, Constants.Layout.topPadding)
            
            HStack(alignment: .top) {
                Text(Constants.Text.totalAmount)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(Constants.Text.textGray))
                if let amount = hotel.totalAmount {
                    Text("\(amount) " + Constants.Text.rubleSign)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color(Constants.Text.navButton))
                        .fontWeight(.semibold)
                }
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
