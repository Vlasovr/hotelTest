//
//  BookingViewModel.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI
import Combine

@MainActor
final class BookingViewModel: BookingFlowState {
    
    private enum Constants {
        enum Values {
           static let ordinals = ["Первый", "Второй", "Третий", "Четвертый", "Пятый", "Шестой", "Седьмой", "Восьмой"]
            static let maxTouristCount = 8
            static let range = 100000...999999
            static let rubleSign = " ₽"
        }
    }
    
    @Published var tourists: [Tourist] = [Tourist()]
    @Published var hotel: HotelBooking?
    @Published var errorMessage: String?
    @Published var isDataLoading = true
    @Published var customersPhone: String?
    @Published var customersMail: String?
    @Published var touristHides: [Bool] = Array(repeating: false, count: Constants.Values.maxTouristCount)
    @Published var isShowAlert = false
    @Published var isShowErrorAlert = false
    @Published var isInputConfirmed = false
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    init(path: Binding<NavigationPath>,
         networkService: NetworkServiceProtocol = NetworkService()
    ) {
        self.networkService = networkService
        super.init(path: path) 
    }
    
    func getBookingData() {
        let hotelPublisher: AnyPublisher<HotelBooking, Error> = networkService.client.request(endpoint: .booking)

            hotelPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.handleError(error)
                    }
                }, receiveValue: { [weak self] hotelData in
                    self?.hotel = hotelData
                    self?.isDataLoading = false
                    self?.calculateTourAmount()
                })
                .store(in: &cancellables)
        }
    
    var touristsCount: Int {
        return tourists.count
    }

       func addTourist() {
           guard tourists.count < Constants.Values.maxTouristCount else {
               isShowAlert.toggle()
               return
           }
           
           let newTourist = Tourist()
           self.tourists.append(newTourist)
       }

    func russianOrdinalNumberString(from index: Int) -> String {
        guard index < Constants.Values.maxTouristCount else { return "" }
        
        return Constants.Values.ordinals[index]
    }
    
    func hideBindingForTourist(at index: Int) -> Binding<Bool> {
        guard touristHides.indices.contains(index) else {
            return Binding<Bool>(
                      get: { false },
                      set: { _ in }
                  )
        }
        
        return Binding<Bool>(
            get: { self.touristHides[index] },
            set: { self.touristHides[index] = $0 }
        )
    }
    
    func calculateTourAmount()  {
        guard let price = hotel?.tourPrice,
                let fuelCharge = hotel?.fuelCharge,
              let serviceCharge = hotel?.serviceCharge else { return }
        hotel?.totalAmount = price + fuelCharge + serviceCharge
    }
    
    func setupAmountToNavButton() -> String {
        guard let totalAmount = hotel?.totalAmount else { return "" }
        return CurrencyFormatter.format(amount: Double(totalAmount)) + Constants.Values.rubleSign
    }
    
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
    }
    
    private func generateBookingNumber() -> String {
        let number = Int.random(in: Constants.Values.range)
        return String(number)
    }
    
    func showPaymentSuccessed() {
        if isInputConfirmed {
            path.append(BookingLink.paymentSuccessed(orderNumber: generateBookingNumber()))
        } else {
            isShowErrorAlert.toggle()
        }
    }
    
    func popView() {
        path.removeLast()
    }
}
