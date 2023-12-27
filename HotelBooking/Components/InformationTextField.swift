//
//  InformationTextField.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//
import SwiftUI
import Combine

struct InformationTextField: View {
    
    private enum Constants {
        enum Layout {
            static let titleFontSize: CGFloat = 12
            static let topPadding: CGFloat = 10
            static let leadingPadding: CGFloat = 15
            static let cornerRadius: CGFloat = 10
            static let opacity: CGFloat = 0.15
        }
        
        enum Text {
            static let textField = "textField"
            static let errorField = "errorField"
            static let textFieldTitle = "textFieldTitle"
            static let phonePlaceholder = "+7 (***) ***-**-**"
            static let mailPlaceholder = "example@mail.ru"
            static let name = "Имя"
            static let surname = "Фамилия"
            static let phone = "Телефон"
            static let mail = "Почта"
        }
    }
    
    enum TextFieldType {
        case phone, email, basic, name, surname
    }
    
    let type: TextFieldType
    @Binding var text: String
    var basicTitle: String?
    
    @State private var isPhoneValid = false
    @State private var isEmailValid = false
    @State private var isNameValid = false
    @State private var isSurnameValid = false
    @State private var isBasicValid = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if type != .basic {
                Text(title)
                    .font(.system(size: Constants.Layout.titleFontSize, weight: .regular))
                    .foregroundColor(Color(Constants.Text.textFieldTitle))
                    .padding(.top, Constants.Layout.topPadding)
                    .padding(.leading, Constants.Layout.leadingPadding)
            }
            TextField(placeholder, text: $text)
                .keyboardType(type == .phone ? .numberPad : .default)
                .padding(.leading, Constants.Layout.leadingPadding)
                .padding(.top, type == .basic ? Constants.Layout.leadingPadding :
                            -Constants.Layout.topPadding
                )
                .padding(.bottom, type == .basic ? Constants.Layout.leadingPadding :
                            Constants.Layout.topPadding
                )
                .foregroundColor(.black)
                .focused($isFocused)
                .onChange(of: isFocused) {
                    validateText()
                }
                .onChange(of: text) {
                    if type == .phone {
                        validateText()
                    }
                }
            
        }
        .background(backgroundColor)
        .cornerRadius(Constants.Layout.cornerRadius)
        .background(.white)
    }
    
    private var title: String {
        switch type {
        case .phone:
            return Constants.Text.phone
        case .email:
            return Constants.Text.mail
        case .name:
            return Constants.Text.name
        case .surname:
            return Constants.Text.surname
        case .basic:
            return ""
        }
    }
    
    private var placeholder: String {
        switch type {
        case .phone:
            return Constants.Text.phonePlaceholder
        case .email:
            return Constants.Text.mailPlaceholder
        case .name:
            return Constants.Text.name
        case .surname:
            return Constants.Text.surname
        case .basic:
            return basicTitle ?? ""
        }
    }
    
    private var backgroundColor: Color {
        if text.isEmpty {
            return Color(Constants.Text.textField)
        } else {
            switch type {
            case .phone:
                return isPhoneValid ? Color(Constants.Text.textField) :
                Color(Constants.Text.errorField).opacity(Constants.Layout.opacity)
            case .email:
                return isEmailValid ?Color(Constants.Text.textField) :
                Color(Constants.Text.errorField).opacity(Constants.Layout.opacity)
            case .name:
                return isNameValid ? Color(Constants.Text.textField) :
                Color(Constants.Text.errorField).opacity(Constants.Layout.opacity)
            case .surname:
                return isSurnameValid ? Color(Constants.Text.textField) :
                Color(Constants.Text.errorField).opacity(Constants.Layout.opacity)
            case .basic:
                return isBasicValid ? Color(Constants.Text.textField) :
                Color(Constants.Text.errorField).opacity(Constants.Layout.opacity)
            }
        }
    }
    
    private func validateText() {
        if !isFocused || (!(type == .basic) && !text.isEmpty) {
            switch type {
            case .phone:
                let formattedPhoneNumber = InputValidator.formatPhoneNumber(number: text)
                if self.text != formattedPhoneNumber {
                    self.text = formattedPhoneNumber
                }
                isPhoneValid = InputValidator.isValidPhone(formattedPhoneNumber)
            case .email:
                isEmailValid = InputValidator.isValidEmail(text)
            case .name:
                isNameValid = InputValidator.isValidName(text)
            case .surname:
                isSurnameValid = InputValidator.isValidSurname(text)
            case .basic:
                isBasicValid = InputValidator.isValidBasic(text)
            }
        }
    }
    
    private func isFieldValid() -> Bool {
        switch type {
        case .phone:
            return isPhoneValid
        case .email:
            return isEmailValid
        case .basic:
            return isBasicValid
        case .name:
            return isNameValid
        case .surname:
            return isSurnameValid
        }
    }
}
