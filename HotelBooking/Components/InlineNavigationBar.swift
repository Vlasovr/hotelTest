//
//  InlineNavigationBar.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct InlineNavigatonBar: View {
    
    private enum Constants {
        enum Images {
            static let backButton = Image(systemName: "chevron.left")
        }
        
        enum Layout {
            static let backButtonWidth: CGFloat = 14
            static let backButtonHeight: CGFloat = 16
            static let stackPadding: CGFloat = 8
            static let buttonHorizontalPadding: CGFloat = 16
            static let titleFontSize: CGFloat = 18
            static let titlePudding: CGFloat = -16
        }
    }
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack  {
                Button(action: action) {
                    Constants.Images.backButton
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: Constants.Layout.backButtonWidth,
                            height: Constants.Layout.backButtonHeight
                        )
                        .fontWeight(.medium)
                        .tint(.black)
                }
                Spacer()
                VStack(alignment: .center) {
                    Text(title)
                        .font(Font.system(size: Constants.Layout.titleFontSize)
                            .weight(.medium))
                        .padding(.leading, Constants.Layout.titlePudding)
                }
                Spacer()
            }
            .padding(.vertical, Constants.Layout.stackPadding)
            .padding(.horizontal,
                Constants.Layout.buttonHorizontalPadding
            )
            Divider()
        }
        .background(.white)
    }
}
