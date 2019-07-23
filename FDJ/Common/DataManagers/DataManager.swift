//
//  DataController.swift
//  LoginCoordinator
//
//  Created by Sandy on 2019-05-18.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


class DataManager: BaseDataManager {
    override func get<T>(_ itemCollection: T.Type, for service: APIService, completion: @escaping Handler) where T : Decodable {
        client.get(with: service) { [weak self] results in
            switch results {
            case .dict(let dict):
                guard let array = dict[service.key] as? [[String: Any]] else {
                    if let _ = dict[service.key] {
                         completion(.failure(.resultNull))
                         return
                    }
                    completion(.failure(.jsonParsingFailure))
                    return
                }
                let collection = array.map({ dict -> T? in
                    return try? self?.jsonEncoder(dict, with: service.key, for: T.self)
                })
                completion(.success(collection))
            case .data, .array: break
            case .error(let reason): completion(.failure(reason))
            }
        }
    }
}

