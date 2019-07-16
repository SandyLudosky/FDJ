//
//  Protocols.swift
//  LoginCoordinator
//
//  Created by Sandy on 2019-05-18.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


protocol ViewProtocol {
    associatedtype T
    //var presenter: PresenterProtocol? { get set }
    func setup()
    func show()
    func startLoading()
    func stopLoading()
    func didSucceed(with data: [T])
    func didFail(with error: Error)
  
}
protocol PresenterProtocol {
    associatedtype T
    associatedtype View
    var message: String? { get set }
    init(with view: View, and service: APIProtocol)
    func fetch(with service: APIProtocol, callBack: @escaping ([T]) -> Void)
}
