//
//  BookingView.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI

struct BookingView: View {
    
    private enum Constants {
        enum Layout {
            static let cornerRadius: CGFloat = 12
            static let scaleEffect: CGFloat = 3
            static let padding: CGFloat = 5
        }
        
        enum Text {
            static let tourist = " турист"
            static let pay = "Оплатить"
            static let navButton = "navigationButton"
            static let booking = "Бронирование"
            static let bg = "bg"
            static let amount = "Вы достигли максимального количества туристов"
            static let ok = "OK"
            static let subWarning = "Вы не можете добавить более 8 туристов."
            static let error = "Ошибка"
            static let enterFields = "Заполните все поля"
        }
    }
    
    @StateObject var viewModel: BookingViewModel
    @FocusState var isKeyboardVisible
    
    var body: some View {
        BookingFlowCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        VStack {
            if viewModel.isDataLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(Constants.Layout.scaleEffect)
            } else {
                if let hotel = viewModel.hotel {
                    ScrollView {
                        HotelMainInfoHeader(hotel: hotel) {}
                            .cornerRadius(Constants.Layout.cornerRadius)
                        Spacer()
                        
                        DetailedBookingInfo(hotel: hotel)
                            .cornerRadius(Constants.Layout.cornerRadius)
                        Spacer()
                        
                        CustomerInfo(
                            phone: viewModel.customersPhone ?? "",
                            email: viewModel.customersMail ?? "",
                            isValid: $viewModel.isInputConfirmed
                        )
                        .focused($isKeyboardVisible)
                        .cornerRadius(Constants.Layout.cornerRadius)
                        Spacer()
                        Spacer()
                        Spacer()
                        ForEach(viewModel.tourists) { tourist in
                            TouristInfo(name: tourist.name,
                                        surname: tourist.surname,
                                        dateOfBirth: tourist.dateOfBirth,
                                        nationality: tourist.nationality,
                                        passportForeignNumber: tourist.passportForeignNumber,
                                        dateDassporForeignDumberExpires: tourist.datePassportForeignNumberExpires, isHide:viewModel.hideBindingForTourist(at: viewModel.tourists.firstIndex { $0.id == tourist.id } ?? .zero),
                                        isValid: $viewModel.isInputConfirmed,
                                        title: viewModel.russianOrdinalNumberString(from: viewModel.tourists.firstIndex { $0.id == tourist.id } ?? .zero) + Constants.Text.tourist
                        )}
                        .focused($isKeyboardVisible)
                        .cornerRadius(Constants.Layout.cornerRadius)
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        AddTouristView {
                            viewModel.addTourist()
                        }
                        .cornerRadius(Constants.Layout.cornerRadius)
                        Spacer()
                        
                        if let hotel = viewModel.hotel {
                            PaymentView(hotel: hotel)
                                .cornerRadius(Constants.Layout.cornerRadius)
                        }
                    }
                }
                NavigationButton(
                    title: Constants.Text.pay + "\(viewModel.setupAmountToNavButton())",
                    primaryColor: Color(Constants.Text.navButton),
                    secondaryColor: .white
                ) {
                    viewModel.showPaymentSuccessed()
                }
                .padding(.horizontal)
                .padding(.top, Constants.Layout.padding)
                .padding(.bottom, Constants.Layout.padding)
            }
        }
        .onTapGesture {
            isKeyboardVisible = false
        }
        .safeAreaInset(edge: .top) {
            InlineNavigatonBar(title: Constants.Text.booking) {
                viewModel.popView()
            }
            .onTapGesture {
                isKeyboardVisible = false
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .background(Color(Constants.Text.bg))
        .alert(Constants.Text.amount, isPresented: $viewModel.isShowAlert) {
            Button(Constants.Text.ok, role: .cancel) { }
        } message: {
            Text(Constants.Text.subWarning)
        }
        .alert(Constants.Text.error, isPresented: $viewModel.isShowErrorAlert) {
            Button(Constants.Text.ok, role: .cancel) { }
        } message: {
            Text(Constants.Text.enterFields)
        }
        .onAppear {
            viewModel.getBookingData()
        }
    }
}
