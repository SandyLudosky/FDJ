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
    var endpoint: Endpoint { get }
    var key: String { get }
    var request: URLRequest? { get }
}


extension APIProtocol {
  
    public    func asURLRequest(queryItems: [URLQueryItem]) throws -> URLRequest? {
        //baseURL + endpoints
        guard let urlStr = URL(string: baseURL),
              let endpoint = endpoint.path
            else { throw ErrorHandler.encodingError }
    
        let urlComponents = urlStr.appendingPathComponent(endpoint)
        guard var components = URLComponents(url: urlComponents, resolvingAgainstBaseURL: false) else { throw ErrorHandler.encodingError }
        components.queryItems = queryItems
        
        //URL
        guard let url = components.url else { throw ErrorHandler.invalidRequest }
        print(url)
        return URLRequest(url: url)
    }
    
    public var request: URLRequest? {
        var queryItems = [URLQueryItem]()
        if let params = endpoint.parameters {
            queryItems += add(params)
        }
        guard let request = try? asURLRequest(queryItems: queryItems) else {
            return nil
        }
        return request
    }
    
    private func add(_ params: [String : Any]) ->  [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value as? String))
        }
        return queryItems
    }
}
