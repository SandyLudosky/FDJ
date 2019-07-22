//
//  QueryItemProvider.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var path: String? { get }
    var parameters: Dictionary<String, Any>? { get }
}

