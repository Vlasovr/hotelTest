//
//  CustomerInfo.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//

import SwiftUI

struct CustomerInfo: View {
    
    private enum Constants {
        enum Layout {
            static let customerInfoFontSize: CGFloat = 22
            static let descriptionFontSize: CGFloat = 14
        }
        
        enum Text {
            static let customerInfo = "Информация о покупателе"
            static let description = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
            static let textGray = "textGray"
        }
    }
    
    @State var phone: String
    @State var email: String
    @Binding var isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Text.customerInfo)
                .font(.system(size: Constants.Layout.customerInfoFontSize, weight: .medium))
                .padding(.vertical)
            InformationTextField(type: .phone, text: $phone)
            InformationTextField(type: .email, text: $email)
            Text(Constants.Text.description)
                .font(.system(size: Constants.Layout.descriptionFontSize, weight: .regular))
                .foregroundColor(Color(Constants.Text.textGray))
            Spacer()
            Spacer()
        }
        .padding(.horizontal)
        .background(.white)
        .onChange(of: email) {
            checkIsFieldsValid()
        }
        .onChange(of: phone) {
            checkIsFieldsValid()
        }
    }
}

extension CustomerInfo {
    private func checkIsFieldsValid() {
        isValid = InputValidator.isValidEmail(email) && InputValidator.isValidPhone(phone)
    }
}
