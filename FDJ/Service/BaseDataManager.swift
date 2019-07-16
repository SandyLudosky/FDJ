//
//  DataManager.swift
//  HenriPotierSwift
//
//  Created by Sandy on 2019-06-10.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

typealias Handler = (Result<Any>) -> Void
protocol DataManagerProtocol {
    associatedtype P
    func get<T: Decodable>(_ itemCollection: T.Type, for service: P, completion: @escaping Handler)
    func post<T: Decodable>(_ itemCollection: T.Type, for service: P, completion: @escaping Handler)
}

class BaseDataManager: DataManagerProtocol {
    var client = APIClient<APIService>()
    func post<T: Decodable>(_ itemCollection: T.Type, for service: APIService, completion: @escaping Handler) {}
    func get<T: Decodable>(_ itemCollection: T.Type, for service: APIService, completion: @escaping Handler) {
        client.get(with: service) { results in
            switch results {
            case .array, .dict, .data, .error: break
            }
        }
    }
    func jsonEncoder<T: Decodable>(_ json: [String : Any], with key: String, for type: T.Type)  throws -> T {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            throw ErrorHandler.invalidData
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
