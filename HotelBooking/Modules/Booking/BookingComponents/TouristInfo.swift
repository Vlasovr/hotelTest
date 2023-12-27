//
//  TouristInfo.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//

import SwiftUI

struct TouristInfo: View {
    
    private enum Constants {
        enum Layout {
            static let fontSize: CGFloat = 22
            static let buttonWidth: CGFloat = 16
            static let buttonHeight: CGFloat = 14
            static let padding: CGFloat = 10
            static let opacity: CGFloat = 0.1
            static let cornerRadius: CGFloat = 6
        }
        
        enum Text {
            static let up = "chevron.up"
            static let down = "chevron.down"
            static let navButton = "navigationButton"
            static let dateOfBirth = "Дата рождения"
            static let nationality = "Гражданство"
            static let foreignPassportNumber = "Номер загранпаспорта"
            static let dateOfPassport = "Срок действия загранпаспорта"
        }
    }
    
    @State var name: String
    @State var surname: String
    @State var dateOfBirth: String
    @State var nationality: String
    @State var passportForeignNumber: String
    @State var dateDassporForeignDumberExpires: String
    @Binding var isHide: Bool
    @Binding var isValid: Bool
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.system(size: Constants.Layout.fontSize, weight: .medium))
                    .padding(.vertical)
                Spacer()
                Button {
                    withAnimation {
                        isHide.toggle()
                    }
                } label: {
                    Image(systemName: isHide ? Constants.Text.down: Constants.Text.up)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constants.Layout.buttonWidth,
                            height: Constants.Layout.buttonHeight
                        )
                        .padding(.horizontal, Constants.Layout.padding)
                        .padding(.vertical, Constants.Layout.padding)
                        .background(Color(Constants.Text.navButton).opacity(Constants.Layout.opacity))
                        .cornerRadius(Constants.Layout.cornerRadius)
                }
                
            }
            if !isHide {
                InformationTextField(
                    type: .name,
                    text: $name
                )
                InformationTextField(
                    type: .surname,
                    text: $surname
                )
                InformationTextField(
                    type: .basic,
                    text: $dateOfBirth,
                    basicTitle: Constants.Text.dateOfBirth
                )
                InformationTextField(
                    type: .basic,
                    text: $nationality,
                    basicTitle: Constants.Text.nationality
                )
                InformationTextField(
                    type: .basic,
                    text: $passportForeignNumber,
                    basicTitle: Constants.Text.foreignPassportNumber
                )
                InformationTextField(
                    type: .basic,
                    text: $dateDassporForeignDumberExpires,
                    basicTitle: Constants.Text.dateOfPassport
                )
                Spacer()
                Spacer()
            }
        }
        .padding(.horizontal)
        .background(.white)
        .onChange(of: name) {
            checkIsFieldsValid()
        }
        .onChange(of: surname) {
            checkIsFieldsValid()
        }
        .onChange(of: dateOfBirth) {
            checkIsFieldsValid()
        }
        .onChange(of: nationality) {
            checkIsFieldsValid()
        }
        .onChange(of: passportForeignNumber) {
            checkIsFieldsValid()
        }
        .onChange(of: dateDassporForeignDumberExpires) {
            checkIsFieldsValid()
        }
    }
}

extension TouristInfo {
  private func checkIsFieldsValid() {
        isValid = InputValidator.isValidName(name) &&
        InputValidator.isValidSurname(surname) &&
        InputValidator.isValidBasic(dateOfBirth) &&
        InputValidator.isValidBasic(passportForeignNumber) &&
        InputValidator.isValidBasic(dateDassporForeignDumberExpires)
    }
}
