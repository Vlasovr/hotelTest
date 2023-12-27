//
//  HttpClient.swift
//  Triodos
//
//  Created by Роман Власов on 24.12.23.
//

import Foundation
import Combine


typealias HttpHeaders = [String: String]
typealias HttpQueryItems = [String: String]
typealias Parameters = [String: Any?]

protocol HttpClientProtocol {
    func request<T: Decodable>(endpoint: HotelAPIEndpoint) -> AnyPublisher<T, Error>
}

final class HttpClient: HttpClientProtocol {
    private enum Constants {
        static let firstRunTimeout: Int = 3
        static let loginTimeout: Int = 10
    }
    
    func request<T: Decodable>(endpoint: HotelAPIEndpoint) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        let timeout: Int = endpoint.parameters == nil ? Constants.firstRunTimeout : Constants.loginTimeout
        urlRequest.timeoutInterval = TimeInterval(timeout)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
