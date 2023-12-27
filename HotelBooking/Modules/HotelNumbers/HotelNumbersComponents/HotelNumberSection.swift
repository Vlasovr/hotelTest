//
//  HotelNumberSection.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI
import SwiftUI

struct HotelNumberSection: View {
    private enum Constants {
        enum Layout {
            static let imageHeight: CGFloat = 257
            static let cornerRadius: CGFloat = 15
            static let visibleIndicators = 5
        }
        
        enum Text {
            static let chooseNumber = "Выбрать номер"
            static let navButton = "navigationButton"
        }
    }
    
    @StateObject var viewModel: HotelNumbersViewModel
    var number: Number
    @State var currentIndex = 0
    
    var body: some View {
        
        VStack {
            if let images = number.images {
                TabView(selection: $currentIndex) {
                    ForEach(images.indices, id: \.self) { index in
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                            .frame(height: Constants.Layout.imageHeight)
                            .cornerRadius(Constants.Layout.cornerRadius)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: Constants.Layout.imageHeight)
                .cornerRadius(Constants.Layout.cornerRadius)
                .overlay(alignment: .bottom) {
                    ImageControl(
                        currentIndex: $currentIndex,
                        total: images.count,
                        visibleIndicators: Constants.Layout.visibleIndicators
                    )
                }
                HotelNumberDescription(number: number)
                NavigationButton(
                    title: Constants.Text.chooseNumber,
                    primaryColor: Color(Constants.Text.navButton),
                    secondaryColor: .white
                ) {
                    viewModel.showBookingScreen()
                }
                Spacer()
            }
        }
        .padding()
        .background(.white)
    }
}

