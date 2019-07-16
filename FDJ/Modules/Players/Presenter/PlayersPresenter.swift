//
//  PlayersPresenter.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


class PlayersPresenter: PresenterProtocol {
    var dataManager: DataManager?
    var view: ViewProtocol?
    typealias T = Player
    
    required init(with view: ViewProtocol) {
        self.view = view
        dataManager = DataManager()
    }
    
    func fetch(with service: APIService) {
        self.view?.startLoading()
        dataManager?.get(Player.self, for: service, completion: { results in
            switch results {
            case .success(let collection):
                guard let teams = collection as? [Player] else { return }
                DispatchQueue.main.async {
                    self.view?.didSucceed(with: teams)
                    self.view?.stopLoading()
                }
            case .failure(let error): self.view?.didFail(with: error)
            }
        })
    }
    
}
