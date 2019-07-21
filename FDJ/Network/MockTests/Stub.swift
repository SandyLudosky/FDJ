//
//  Stub.swift
//  FDJ
//
//  Created by Sandy on 2019-07-21.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

typealias CompletionHandler = (Result<Any>) -> Void

protocol TestStub {
    associatedtype T
    associatedtype E
    var results: Result<Any> { get }
    init(teams: [T])
    init(error: E)
    func get(_ completion: CompletionHandler)
}

class Stub: TestStub {
    typealias T = TeamViewModel
    typealias E = ErrorHandler
    var results: Result<Any>
    
    required init(teams: [TeamViewModel]) {
        self.results = .success(teams)
    }
    
    required init(error: ErrorHandler) {
        self.results = .failure(error)
    }
    
    func get(_ completion: (Result<Any>) -> Void) {
        completion(results)
    }
}
