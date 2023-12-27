//
//  MoreInfoSection.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct MoreInfoSection: View {
    
    private enum Constants {
        enum Layout {
            static let headerTitleFontSize: CGFloat = 16
            static let titleFontSize: CGFloat = 14
        }
        
        enum Text {
            static let textGray = "textGray"
            static let backButton = "chevron.right"
            static let bg = "bg"
        }
    }
    
    let imageName: String
    let headerTitle: String
    let title: String
    let action: () -> Void

    var body: some View {
            HStack {
                Image(imageName)
                VStack(alignment: .leading) {
                    Text(headerTitle)
                        .font(.system(size: Constants.Layout.headerTitleFontSize, weight: .medium))
                    Text(title)
                        .font(.system(size: Constants.Layout.titleFontSize, weight: .medium))
                        .foregroundColor(Color(Constants.Text.textGray))
                }
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: Constants.Text.backButton)
                        .foregroundColor(.black)
                }
            }
            .listRowBackground(Color(Constants.Text.bg))
    }
}

