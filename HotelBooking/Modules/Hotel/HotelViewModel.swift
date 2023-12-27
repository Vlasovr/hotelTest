//
//  HotelViewModel.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI
import Combine

@MainActor
final class HotelViewModel: HotelFlowState {
    var isDataLoading = true
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    @Published var hotelData: HotelData?
    @Published var hotelImages: [UIImage] = []
    @Published var errorMessage: String?
    
    var peculiaritiesRowsCount: Int {
        ((hotelData?.aboutTheHotel.peculiarities.count ?? 1) + 1) / 2
    }
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getHotelData() {
        let hotelPublisher: AnyPublisher<HotelData, Error> = networkService.client.request(endpoint: .hotel)
        
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
                self?.hotelData = hotelData
                self?.loadImages(for: hotelData.imageUrls)
            })
            .store(in: &cancellables)
    }
    
    func loadImages(for urls: [String]) {
        let imagePublishers = urls.compactMap { URL(string: $0) }.map {
            networkService.fetchImage(from: $0)
        }
        
        Publishers.MergeMany(imagePublishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                self?.isDataLoading = false
            }, receiveValue: { [weak self] images in
                self?.hotelImages = images.compactMap { $0 }
            })
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
        self.errorMessage = error.localizedDescription
    }
    
    func showHotelNumber() {
        path.append(HotelLink.hotelNumber(hotelName: hotelData?.name ?? "default title"))
    }
}

extension HotelViewModel {
    enum Defaults {
        static let images = ["1", "2", "1", "2", "1", "2", "1", "2"]
        static let options = ["3-я линия", "Платный вайфай в фое", "30 км до аэеропорта", "1 км до пляжа"]
        static let description = "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!"
    }
}
