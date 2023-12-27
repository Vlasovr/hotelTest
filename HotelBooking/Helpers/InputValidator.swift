//
//  InputValidator.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//

import Foundation

struct InputValidator {
    
    static func isValidPhone(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^(\\+7|7|8)?([\\- ]?)\\(?\\d{3}\\)?([\\- ]?)\\d{3}([\\- ]?)\\d{2}([\\- ]?)\\d{2}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-zА-Яа-яЁё ]+$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: name)
    }

    static func isValidSurname(_ surname: String) -> Bool {
        let surnameRegex = "^[A-Za-zА-Яа-яЁё ]+$"
        let surnameTest = NSPredicate(format: "SELF MATCHES %@", surnameRegex)
        return surnameTest.evaluate(with: surname)
    }
    static func isValidBasic(_ text: String) -> Bool {
        return !text.isEmpty
    }
    
    static func formatPhoneNumber(number: String) -> String {
        var cleanPhoneNumber = number.filter("0123456789".contains)
        if cleanPhoneNumber.hasPrefix("7") || cleanPhoneNumber.hasPrefix("8") {
            cleanPhoneNumber.removeFirst()
        }
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        let mask = "+7 (XXX) XXX-XX-XX"
        var maskIndex = mask.startIndex
        
        while maskIndex < mask.endIndex {
            if mask[maskIndex] == "X" {
                if index < cleanPhoneNumber.endIndex {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append("*")
                }
            } else {
                result.append(mask[maskIndex])
            }
            maskIndex = mask.index(after: maskIndex)
        }
        
        return result
    }
}
