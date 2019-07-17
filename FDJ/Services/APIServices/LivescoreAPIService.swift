//
//  LivescoreAPIService.swift
//  FDJ
//
//  Created by Sandy on 2019-07-17.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


public enum LivescoreAPIService: APIProtocol {
    case original(_ url:String), preview(_ url:String)
    
    public var baseURL: String {
        return "https://www.thesportsdb.com/api/v1/json/1/"
    }
    
    public var endpoint: String {
        switch self {
            
        case .original(let url): return url
        case .preview(let url): return "\(url)/preview"
        }
    }
    
    public var key: String {
        return ""
    }
    public var httpType: RequestType {
        return .get
    }
    
    public var parameters: [String : Any]? {
        return nil
    }
}
