//
//  Protocols.swift
//  LoginCoordinator
//
//  Created by Sandy on 2019-05-18.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation
import UIKit

protocol ViewProtocol {
    var interactor: InteractorProtocol? { get set }
    func setup()
    func show()
    func startLoading()
    func stopLoading()
    func didSucceed<VM: ViewModelProtocol>(with results: [VM])
    func didFail(with error: ErrorHandler)
}

protocol InteractorProtocol {
    var dataManager: DataManager? { get set }
    var presenter:PresenterProtocol? { get set }
    func fetch(with service: APIService)
}

protocol PresenterProtocol {
      var view: ViewProtocol? { get set }
      init(with view: ViewProtocol)
      func didSucceed(_ viewModel: Any)
      func didFail(_ error: ErrorHandler)
}

