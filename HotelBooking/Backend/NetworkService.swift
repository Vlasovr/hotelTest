//
//  BackendService.swift
//  Triodos
//
//  Created by Роман Власов on 24.12.23.
//

import UIKit
import Combine

protocol NetworkServiceProtocol {
    var client: HttpClientProtocol { get }
    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}

final class NetworkService: NetworkServiceProtocol {
    var client: HttpClientProtocol {
        HttpClient()
    }
    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
