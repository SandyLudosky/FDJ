//
//  DataController.swift
//  LoginCoordinator
//
//  Created by Sandy on 2019-05-18.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

typealias Handler = (Result<Any>) -> Void
protocol DataManagerProtocol {
    func get(for service: APIService, completion: @escaping Handler)
    func post(for service: APIService, completion: @escaping Handler)
}
class DataManager {
    let client = APIClient<APIService>()
}

extension DataManager: DataManagerProtocol {
    func post(for service: APIService, completion: @escaping Handler) {
        client.post(with: service) { results in
            switch results {
            case .data(let data):
                if let dataValid = data as? Data {
                    completion(.success(dataValid))
                }
            case .dict(let dict):
                guard let token = dict["token"] as? String else { return }
                DispatchQueue.main.async {
                    completion(.success(token))
                }
            case .array(_) : break
            case .error(let reason): completion(.failure(reason))
            }
        }
    }
    
    func get(for service: APIService, completion: @escaping Handler) {
        client.get(with: service) { results in
            switch results {
            case .data(let data):
                if let dataValid = data as? Data {
                    completion(.success(dataValid))
                }
            case .dict(let dict):
                print(dict)
    
            case .array(_) : break
            case .error(let reason): completion(.failure(reason))
            }
        }
    }
}

