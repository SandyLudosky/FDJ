//
//  HomePresenter.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: PresenterProtocol {
    typealias T = Team
    var view: ViewProtocol?
    
    required init(with view: ViewProtocol) {
        self.view = view
    }
    func didSucceed(_ viewModel: Any) {
        self.view?.stopLoading()
        self.view?.didSucceed(with: viewModel as! [TeamViewModel])
    }
    
    func didFail(_ error: ErrorHandler) {
        self.view?.didFail(with: error)
        self.view?.stopLoading()
    }
}
