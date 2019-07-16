//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum APIService: APIProtocol {
    case login([String : Any]), me(String), download(String, String) //to download media
    
    public var baseURL: String {
        return "https://us-central1-student-pop-technical-test.cloudfunctions.net/api"
    }
    public var httpType: RequestType {
        switch self {
        case .login: return .post
        case .me, .download: return .get
        }
    }
    public var endpoint: String? {
        switch self {
        case .login: return "login"
        case .me:  return "me"
        case .download(_, let url): return url
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .login(let credentials): return credentials
        case .me(let token), .download(let token,_ ):  return ["token": token]
        }
    }
}

extension APIService {
    public var request: URLRequest? {
        var queryItems = [URLQueryItem]()
        switch self {
            case .login(_): break
            case .me(let token), .download(let token,_ ): queryItems.append(URLQueryItem(name: "token", value: token))
        }
        guard let params = parameters else { return nil }
        guard let urlRequest = try? asURLRequest(for: httpType, with: params, queryItems: queryItems) else {
            return nil
        }
    
        return urlRequest
    }
}
