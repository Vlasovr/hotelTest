//
//  Tourist.swift
//  HotelBooking
//
//  Created by Роман Власов on 25.12.23.
//
import Foundation
import Combine

class Tourist: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var surname: String
    @Published var dateOfBirth: String
    @Published var nationality: String
    @Published var passportForeignNumber: String
    @Published var datePassportForeignNumberExpires: String

    init(name: String = "",
         surname: String = "",
         dateOfBirth: String = "",
         nationality: String = "",
         passportForeignNumber: String = "",
         datePassportForeignNumberExpires: String = "") {
        self.name = name
        self.surname = surname
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.passportForeignNumber = passportForeignNumber
        self.datePassportForeignNumberExpires = datePassportForeignNumberExpires
    }
    
    static func == (lhs: Tourist, rhs: Tourist) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

