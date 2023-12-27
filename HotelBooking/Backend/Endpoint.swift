//
//  Endpoint.swift
//  Triodos
//
//  Created by Роман Власов on 24.12.23.
//

import Foundation
import Combine


enum APIService: String {
    case core
    case mockbank
    case auth
    case notification
    
    var urlPathComponent: String {
        switch self {
        case .core:
            return "core"
        case .mockbank:
            return "mock-bank"
        case .auth:
            return "auth"
        case .notification:
            return "notification"
        }
    }
}

enum APIEnvironment: String {
    case dev
    case test
    case prod
    
    var baseURL: String {
        switch self {
        case .dev:
            return "http://10.10.14.72:5000"
        case .test:
            return "http://test-server-url"
        case .prod:
            return "http://prod-server-url"
        }
    }
    
    func baseURL(forService service: APIService) -> String {
        return "\(baseURL)/\(service.urlPathComponent)"
    }
}

private enum Constants {
    
    enum Header {
        static let contentTypeKey: String = "Content-Type"
        static let contentTypeValue: String = "application/json"
        
        static let acceptKey: String = "accept"
        static let acceptValue: String = "*/*"
    }
}

protocol Endpoint {
    var urlString: String { get }
    var url: URL? { get }
    var queryItems: HttpQueryItems? { get }
    var httpMethod: HttpMethod { get }
    var headers: HttpHeaders { get }
    var parameters: Parameters? { get }
}

enum HotelAPIEndpoint: Endpoint {
    static let base = "https://run.mocky.io/v3"
    
    case hotel
    case room
    case booking

    var urlString: String {
        switch self {
        case .hotel:
            return "\(HotelAPIEndpoint.base)/d144777c-a67f-4e35-867a-cacc3b827473"
        case .room:
            return "\(HotelAPIEndpoint.base)/8b532701-709e-4194-a41c-1a903af00195"
        case .booking:
            return "\(HotelAPIEndpoint.base)/63866c74-d593-432c-af8e-f279d1a8d2ff"
        }
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    var httpMethod: HttpMethod {
        .get
    }
    
    var headers: HttpHeaders {
        [
            Constants.Header.contentTypeKey: Constants.Header.contentTypeValue,
            Constants.Header.acceptKey: Constants.Header.acceptValue
        ]
    }
    
    var queryItems: HttpQueryItems? {
        nil
    }
    
    var parameters: Parameters? {
        nil
    }
}
