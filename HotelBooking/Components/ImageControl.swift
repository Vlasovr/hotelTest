//
//  ImageControl.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct ImageControl: View {
    private enum Constants {
        enum Layout {
            static let spacing: CGFloat = 5
            static let circleSide: CGFloat = 8
            static let horizontalPadding: CGFloat = 10
            static let verticalPadding: CGFloat = 5
            static let cornerRadius: CGFloat = 5
            static let topPadding: CGFloat = -25
            static let opacity: CGFloat = 0.4
        }
    }
    @Binding var currentIndex: Int
    var total: Int
    var visibleIndicators: Int
    
    var body: some View {
        imageControl(currentIndex: $currentIndex, total: total, visibleIndicators: visibleIndicators)
    }
    
    @ViewBuilder func imageControl(currentIndex: Binding<Int>, total: Int, visibleIndicators: Int) -> some View {
        HStack(spacing: Constants.Layout.spacing) {
            let visibleIndices = currentPageIndicatorIndex(currentIndex: currentIndex.wrappedValue, total: total, visibleIndicators: visibleIndicators)

            ForEach(visibleIndices, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex.wrappedValue ? .black : Color.gray)
                    .opacity(opacityForIndex(index: index, currentIndex: currentIndex.wrappedValue, visibleIndices: visibleIndices))
                    .frame(width: Constants.Layout.circleSide, height: Constants.Layout.circleSide)
            }
        }
        .padding(.horizontal, Constants.Layout.horizontalPadding)
        .padding(.vertical, Constants.Layout.verticalPadding)
        .background(Color.white)
        .cornerRadius(Constants.Layout.cornerRadius)
        .padding(.top, Constants.Layout.topPadding)
    }
    
    func currentPageIndicatorIndex(currentIndex: Int, total: Int, visibleIndicators: Int) -> [Int] {
        var indices = [Int]()
        let halfSide = visibleIndicators / 2
        
        if total <= visibleIndicators {
            indices = Array(0..<total)
        } else if currentIndex <= halfSide {
            indices = Array(0..<visibleIndicators)
        } else if currentIndex >= total - halfSide {
            indices = Array((total - visibleIndicators)..<total)
        } else {
            indices = Array((currentIndex - halfSide)..<(currentIndex + halfSide + 1))
        }
        
        return indices
    }
    
    func opacityForIndex(index: Int, currentIndex: Int, visibleIndices: [Int]) -> Double {
        let maxDistance = Double(visibleIndices.count - 1) / 2
        let distance = Double(abs(currentIndex - index))
        
        return 1.0 - (distance / maxDistance) * Constants.Layout.opacity
    }
}

#Preview {
    HotelView(viewModel: HotelViewModel(networkService: NetworkService()))
}

