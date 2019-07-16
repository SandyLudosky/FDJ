//
//  JSONParser.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

class JSONParser {
    public typealias ResponseHandler = (Response<Any>) -> Void
    static func parse(_ data: Data, completion: @escaping ResponseHandler) {
        do {
            completion(.data(data))
            if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completion(.dict(dict))
            }
            if let arr = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                completion(.array(arr))
            }
        } catch {
            completion(.error(.jsonParsingFailure))
        }
    }
}


