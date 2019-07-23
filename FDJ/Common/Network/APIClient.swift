//
//  APIClient.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

class APIClient<T: APIProtocol> {
    public typealias ResponseHandler = (Response<Any>) -> Void
    public typealias ResultHandler = (Result<Any>) -> Void
    func get(with service: T, block: @escaping ResponseHandler) {
        let task = runTask(with: service) { response in
            self.parseResponse(response, completion: block)
        }
        task?.resume()
    }
    func post(with service: T, block: @escaping ResponseHandler) {
        let task = runTask(with: service) { response in
           self.parseResponse(response, completion: block)
        }
        task?.resume()
    }
}
// MARK: - Private
private extension APIClient {
    private func runTask(with service: APIProtocol, completion: @escaping ResultHandler) -> URLSessionDataTask? {
        guard let request = service.request else {
            return nil
        }
        
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.responseUnsuccessful))
                    return
                }
                switch httpResponse.statusCode {
                case 200 ... 299:
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    completion(.success(data))
                case 300 ... 399 : print("error 300")
                case 400...499:
                    completion(.failure(.responseFailure(.clientError, statusCode: httpResponse.statusCode)))
                    if httpResponse.statusCode == 403 {
                        completion(.failure(.wrongCredentials))
                    }
                case 500 ... 599 :
                    completion(.failure(.responseFailure(.serverError, statusCode: httpResponse.statusCode)))
               
                default : break
                }
            }
        })
    }
    
    private func parseResponse(_ response: Result<Any>, completion: @escaping ResponseHandler) {
        switch response {
        case .success(let data):
            JSONParser.parse(data as! Data, completion: { results in
                switch results {
                case .array(let arr): completion(.array(arr))
                case .dict(let dict): completion(.dict(dict))
                case .data(let data): completion(.data(data))
                case .error(let err): completion(.error(err))
                }
            })
        case .failure(let error): completion(.error(error))
        }
    }
}
