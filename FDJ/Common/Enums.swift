//
//  Enums+Network.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum RequestType: String {
    case get = "GET", post = "POST"
}
public enum Response<U> {
    case array([U])
    case data(U)
    case dict([String: Any])
    case error(ErrorHandler)
}
public enum Result<T> {
    case success(T)
    case failure(ErrorHandler)
}
