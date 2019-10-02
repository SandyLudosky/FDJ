//
//  PlayersPresenter.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

class PlayersPresenter: PresenterProtocol {
    typealias T = Player
    var view: ViewProtocol?
    required init(with view: ViewProtocol) {
        self.view = view
    }
    func didSucceed(_ viewModel: Any) {
        self.view?.startLoading()
        self.view?.didSucceed(with: viewModel as! [PlayerViewModel])
    }
    func didFail(_ error: ErrorHandler) {
        self.view?.startLoading()
        self.didFail(error)
    }

}

