//
//  HotelNumbersViewModel.swift
//  HotelBooking
//
//  Created by Роман Власов on 24.12.23.
//

import SwiftUI
import Combine

@MainActor
final class HotelNumbersViewModel: HotelNumbersFlowState {
    
    @Published var hotelNumbers: HotelNumbers?
    @Published var errorMessage: String?
    @Published var isDataLoading = true
    var hotelName: String
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    init(path: Binding<NavigationPath>,
         networkService: NetworkServiceProtocol = NetworkService(),
         hotelName: String
    ) {
        self.networkService = networkService
        self.hotelName = hotelName
        super.init(path: path)
    }
    
    func getHotelNumbersData() {
            let hotelPublisher: AnyPublisher<HotelNumbers, Error> = networkService.client.request(endpoint: .room)

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
                    self?.hotelNumbers = hotelData
                    hotelData.rooms.enumerated().forEach { index, room in
                        self?.loadImages(for: room, roomIndex: index)
                    }
                })
                .store(in: &cancellables)
        }
        
        func loadImages(for room: Number, roomIndex: Int) {
            let imagePublishers = room.imageUrls.compactMap { URL(string: $0) }.map {
                networkService.fetchImage(from: $0)
            }

            Publishers.MergeMany(imagePublishers)
                .collect()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                        self?.isDataLoading = false
                    }
                }, receiveValue: { [weak self] images in
                    var roomWithImages = room
                    roomWithImages.images = images.compactMap { $0 }
                    
                    if let index = self?.hotelNumbers?.rooms.firstIndex(where: { $0.id == roomWithImages.id }) {
                        self?.hotelNumbers?.rooms[index] = roomWithImages
                    }
                    self?.isDataLoading = false
                })
                .store(in: &cancellables)
        }
    
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
    }
    
    func showBookingScreen() {
        path.append(HotelNumbersLink.booking)
    }
    
    func popView() {
        path.removeLast()
    }
}

