//
//  Enums+Error.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum StatusCode {
    case clientError, serverError
}
extension StatusCode {
    var string: String {
        switch self {
        case .clientError: return "Client Error"
        case .serverError: return "Server Error"
        }
    }
}

public enum ErrorHandler: Error {
    case unknownError
    case invalidData
    case invalidRequest
    case encodingError
    case itemNotFound
    case itemInvalid
    case responseUnsuccessful
    case responseFailure(StatusCode, statusCode: Int)
    case jsonParsingFailure
    case invalidURL
    case noNetwork
    case wrongCredentials
    
    public var description: String? {
        switch self {
        case .unknownError: return NSLocalizedString("Unknown error.", comment: "")
        case .itemNotFound:  return NSLocalizedString("Item not found.", comment: "")
        case .itemInvalid: return NSLocalizedString("Item invalid.", comment: "")
        case .invalidData: return NSLocalizedString("Invalid Data", comment: "")
        case .responseUnsuccessful: return NSLocalizedString("Unsuccessful Response", comment: "")
        case .responseFailure(let statusCode, let code): return NSLocalizedString("\(statusCode) - status code: \(code)", comment: "")
        case .jsonParsingFailure: return NSLocalizedString("Error Parsing JSON", comment: "")
        case .invalidURL: return NSLocalizedString("Invalid URL", comment: "")
        case .encodingError: return NSLocalizedString("Error Encoding URL", comment: "")
        case .invalidRequest: return NSLocalizedString("Invalid Request", comment: "")
        case .noNetwork: return NSLocalizedString("No Network", comment: "")
        case .wrongCredentials: return NSLocalizedString("Wrong Credentials", comment: "")
        }
    }
}

