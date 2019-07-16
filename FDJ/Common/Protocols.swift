//
//  Protocols.swift
//  LoginCoordinator
//
//  Created by Sandy on 2019-05-18.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

protocol ViewProtocol {
    //associatedtype T
    //var presenter: PresenterProtocol? { get set }
    func setup()
    func show()
    func startLoading()
    func stopLoading()
    func didSucceed(with data: [Any])
    func didFail(with error: Error)
  
}
protocol PresenterProtocol {
    associatedtype T
    var view: ViewProtocol? { get set }
    init(with view: ViewProtocol)
    func fetch(with service: APIService)
}
