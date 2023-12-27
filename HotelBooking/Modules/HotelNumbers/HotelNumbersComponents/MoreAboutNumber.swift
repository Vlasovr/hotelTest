//
//  MoreAboutNumber.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct MoreAboutNumber: View {
    private enum Constants {
        enum Layout {
            static let moreFontSize: CGFloat = 16
            static let leadingPadding: CGFloat = 15
            static let width: CGFloat = 220
            static let height: CGFloat = 29
            static let secondLeadingPadding: CGFloat = -10
            static let opacity: CGFloat = 0.1
            static let cornerRadius: CGFloat = 5
        }
        
        enum Text {
            static let more = "Подробнее о номере"
            static let right = "chevron.right"
            static let navButton = "navigationButton"
        }
    }
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(Constants.Text.more)
                    .padding()
                    .font(.system(size: Constants.Layout.moreFontSize, weight: .medium))
                Image(systemName: Constants.Text.right)
                    .fontWeight(.semibold)
                    .padding(.leading, -Constants.Layout.leadingPadding)
            }
            .frame(width: Constants.Layout.width, height: Constants.Layout.height)
            .padding(.leading, Constants.Layout.secondLeadingPadding)
            .foregroundColor(Color(Constants.Text.navButton))
            .background(Color(Constants.Text.navButton).opacity(Constants.Layout.opacity))
            .cornerRadius(Constants.Layout.cornerRadius)
        }
    }
}
