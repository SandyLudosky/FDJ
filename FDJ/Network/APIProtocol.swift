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
    var endpoint: String? { get } // required
    var httpType: RequestType { get }
    var request: URLRequest? { get }
}

extension APIProtocol {
    func asURLRequest(for type: RequestType, with parameters: [String: Any], queryItems: [URLQueryItem]) throws -> URLRequest? {
        var json: [String: Any]? = [:]
        //baseURL + endpoints
        guard let urlStr = URL(string: baseURL),
            var components = URLComponents(url: urlStr.appendingPathComponent(endpoint ?? ""), resolvingAgainstBaseURL: false)
            else { throw ErrorHandler.encodingError }
        
        //parameters
        components.queryItems = queryItems
        // encoded URL
        guard let url = components.url,
            let encodedURL = url.encode()
            else { throw ErrorHandler.invalidRequest }
            var request = URLRequest(url: encodedURL)
            switch type {
            case .get:
            guard let token = parameters["token"] as? String else { return nil }
            request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
            request.addValue(token, forHTTPHeaderField: "token")
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            case .post:
            guard let email = parameters["email"] as? String, let psw = parameters["password"] as? String else { return nil }
            json = ["email": email, "password": psw]
            do {
                let data = try JSONSerialization.data(withJSONObject: json as Any, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = data
            } catch(let error) {
                print(error.localizedDescription)
            }
            }
            
        
            request.httpMethod = httpType.rawValue
            print("request method : \(httpType.rawValue)")
            return request
        }
}
