//
//  APIProtocol.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public protocol APIProtocol {
    var baseURL: String { get }
    var endpoint: String { get } // required
    var httpType: RequestType { get }
    var parameters: [String : Any]? { get }
    var key: String { get }
    var request: URLRequest? { get }
}

extension APIProtocol {
    func asURLRequest(queryItems: [URLQueryItem]) throws -> URLRequest? {
        //baseURL + endpoints
        guard let urlStr = URL(string: baseURL)
            else { throw ErrorHandler.encodingError }
        
        let urlComponents = urlStr.appendingPathComponent(endpoint)
        guard var components = URLComponents(url: urlComponents, resolvingAgainstBaseURL: false) else { throw ErrorHandler.encodingError }
        components.queryItems = queryItems
        
        //URL
        guard let url = components.url else { throw ErrorHandler.invalidRequest }
        print(url)
        return URLRequest(url: url)
    }
}
