//
//  BottomSafeArea.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct BottomSafeAreaView: View {
    private enum Constants {
        enum Layout {
            static let maxHeight: CGFloat = 20
        }
    }
    var body: some View {
        HStack {}
            .frame(maxWidth: .infinity, maxHeight: Constants.Layout.maxHeight)
        .background(.white)
    }
}
