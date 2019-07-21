//
//  APIClientMock.swift
//  FDJ
//
//  Created by Sandy on 2019-07-19.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}


class APIClientMock: APIClient<APIService> {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    var service: APIService?
    init(with service: APIService) {
        self.service = service
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
