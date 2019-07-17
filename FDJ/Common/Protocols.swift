//
//  Protocols.swift
//  LoginCoordinator
//
//  Created by Sandy on 2019-05-18.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

protocol ViewProtocol {
    associatedtype VM 
    func setup()
    func show()
    func startLoading()
    func stopLoading()
    func didSucceed(with data: [VM])
    func didFail(with error: Error)
  
}
protocol PresenterProtocol {
    associatedtype V
    var view: V? { get set }
    init(with view: V)
    func fetch(with service: APIService)
}
