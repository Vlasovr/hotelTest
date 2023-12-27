//
//  PaymentSuccessedView.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct PaymentSuccessedView: View {
    private enum Constants {
        enum Layout {
            static let screenHeight = UIScreen.main.bounds.height
            static let minScreenHeigth: CGFloat = 800.0
            static let circleSide: CGFloat = 94
            static let circleOpacity: CGFloat = 0.1
            static let partySide: CGFloat = 44
            static let conformationFontSize: CGFloat = 22
            static let orderFontSize: CGFloat = 16
            static let smallPadding: CGFloat = 5
        }
        
        enum Text {
            static let party = "party"
            static let orderInWork = "Ваш заказ принят в работу"
            static let conformation = "Подтверждение заказа №"
            static let conformationSecondPard = "может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
            static let textGray = "textGray"
            static let navigationTite = "Супер!"
            static let navigationButton = "navigationButton"
            static let paymentSuccessed = "Заказ оплачен"
        }
    }
    
    @StateObject var viewModel: PaymentSuccessedViewModel
    
    var body: some View {
        PaymentSuccessedFlowCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        VStack {
            Spacer()
            Circle()
                .frame(
                    width: Constants.Layout.circleSide,
                    height: Constants.Layout.circleSide
                )
                .foregroundColor(.gray.opacity(Constants.Layout.circleOpacity))
                .overlay {
                    Image(Constants.Text.party)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constants.Layout.partySide,
                            height: Constants.Layout.partySide
                        )
                }
                .padding()
            Text(Constants.Text.orderInWork)
                .font(.system(size: Constants.Layout.conformationFontSize, weight: .medium))
                .padding()
            Text(Constants.Text.conformation +
                 "\(viewModel.orderNumber)" +
                 Constants.Text.conformationSecondPard
            )
                .font(.system(size: Constants.Layout.orderFontSize, weight: .regular))
                .foregroundColor(Color(Constants.Text.textGray))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            Spacer()
            NavigationButton(
                title: Constants.Text.navigationTite,
                primaryColor: Color(Constants.Text.navigationButton),
                secondaryColor: .white
            ) {
                viewModel.goToHotel()
            }
            .padding(.horizontal)
            .padding(.top, Constants.Layout.smallPadding)
            .padding(.bottom, Constants.Layout.smallPadding)
        }
        .safeAreaInset(edge: .top) {
            InlineNavigatonBar(title: Constants.Text.paymentSuccessed) {
                viewModel.popView()
            }
        }
        .navigationBarBackButtonHidden()

    }
}
