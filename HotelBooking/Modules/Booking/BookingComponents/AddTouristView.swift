//
//  AddTouristView.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//

import SwiftUI

struct AddTouristView: View {
    private enum Constants {
        enum Layout {
            static let addTourist: CGFloat = 22
            static let buttonWidth: CGFloat = 16
            static let buttonHeight: CGFloat = 14
            static let padding: CGFloat = 10
            static let cornerRadius: CGFloat = 6
        }
        
        enum Text {
            static let addTourist = "Добавить туриста"
            static let plus = "plus"
            static let navButton = "navigationButton"
        }
    }
    
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Constants.Text.addTourist)
                    .font(.system(size: Constants.Layout.addTourist, weight: .medium))
                    .padding(.vertical)
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: Constants.Text.plus)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constants.Layout.buttonWidth,
                            height: Constants.Layout.buttonHeight
                        )
                        .padding(.horizontal, Constants.Layout.padding)
                        .padding(.vertical, Constants.Layout.padding)
                        .tint(.white)
                        .background(Color(Constants.Text.navButton))
                        .cornerRadius(Constants.Layout.cornerRadius)
                }
            }
        }
        .padding(.horizontal)
        .background(.white)
    }
}
