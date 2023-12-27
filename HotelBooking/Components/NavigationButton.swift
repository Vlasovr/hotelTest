//
//  NavigationButton.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//


import SwiftUI

struct NavigationButton: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let buttonHeight: CGFloat = 48
        static let buttonlabelPudding: CGFloat = 16
    }
    
    let title: String
    let primaryColor: Color
    let secondaryColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                primaryColor
                Text(title)
                    .padding(Constants.buttonlabelPudding)
                    .foregroundColor(secondaryColor)
            }
            .cornerRadius(Constants.cornerRadius)
            .frame(height: Constants.buttonHeight)
        }
    }
}
