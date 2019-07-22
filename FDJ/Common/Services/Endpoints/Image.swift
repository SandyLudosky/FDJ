//
//  Endpoint.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


public enum Image: Endpoint {
    case original(url:String), preview(url:String)
    public var path: String? {
        switch self {
        case .original(let url): return url
        case .preview(let url): return "\(url)/preview"
        }
    }
    
    public var parameters: Dictionary<String, Any>? {
          return nil
    }
}
