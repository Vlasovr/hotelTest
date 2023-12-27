//
//  HttpError.swift
//  Triodos
//
//  Created by Роман Власов on 24.12.23.
//

import Foundation
import Combine

enum HttpError: Int {
    case clientErrorsStartPoint = 400
    case unauthorized = 401
    case success = 200
    case created = 201
    case emptyBody = 204
    case forbidden = 403
    case notFound = 404
    case notValidTime = 406
    case notConnectedToInternet = -1009
}

enum NetworkError: LocalizedError, CaseIterable {
    case notAcceptable
    case notFound
    case forbidden
    case badRequest
    case unknownError
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .badRequest:
            return Constants.badRequestDescription
        case .unauthorized:
            return Constants.unauthorizedDescription
        case .forbidden:
            return Constants.forbiddenDescription
        case .notFound:
            return Constants.notFoundDescription
        case .notAcceptable:
            return Constants.unacceptableDescription
        case .unknownError:
            return Constants.unknownErrorDescription
        }
    }

    var errorTitle: String {
      switch self {
      case .badRequest:
          return Constants.badRequestTitle
      case .unauthorized:
          return Constants.unauthorizedTitle
      case .forbidden:
          return Constants.forbiddenTitle
      case .notFound:
          return Constants.notFoundTitle
      case .notAcceptable:
          return Constants.notAcceptableTitle
      case .unknownError:
          return Constants.oops
      }
    }

    var errorMessage: String {
      switch self {
      case .badRequest:
          return Constants.badRequestMessage
      case .unauthorized:
          return Constants.unauthorizedMessage
      case .forbidden:
          return Constants.forbiddenMessage
      case .notFound:
          return Constants.notFoundMessage
      case .notAcceptable:
          return Constants.notAcceptableMessage
      case .unknownError:
          return Constants.somethingWentWrong
      }
    }

    func asPublisher<T>() -> AnyPublisher<T, Error> {
        Fail(error: self).eraseToAnyPublisher()
    }
}

private enum Constants {
    static let badRequestTitle = "Invalid Request"
    static let unauthorizedTitle = "Unauthorized"
    static let forbiddenTitle = "Access Denied"
    static let notFoundTitle = "Not Found"
    static let notAcceptableTitle = "Scheduling Conflict"
    static let oops = "Oops!"
    static let badRequestMessage = "The request was unsuccessful due to invalid data. \n Please check your input and try again."
    static let unauthorizedMessage = "Your request requires authentication. \n Please log in and try again."
    static let forbiddenMessage = "You do not have the necessary permissions to perform this action."
    static let notFoundMessage = "The requested resource could not be found. \n Please check your input or try again later."
    static let notAcceptableMessage = "It looks like you have already created an event for this time in the ‘Event room’."
    static let somethingWentWrong = "Something went wrong during your request. \n Please try again later."
    static let badRequestDescription = "Code=400, Bad Request"
    static let unauthorizedDescription = "Code=401, Unauthorized"
    static let forbiddenDescription = "Code=403, Forbidden"
    static let notFoundDescription = "Code=404, Not Found"
    static let unacceptableDescription = "Code=406, Not Acceptable"
    static let unknownErrorDescription = "Unknown error"
    static let contentTypeKey = "Content-Type"
    static let contentTypeValue = "application/json"
    static let acceptKey = "accept"
    static let acceptValue = "*/*"
}
