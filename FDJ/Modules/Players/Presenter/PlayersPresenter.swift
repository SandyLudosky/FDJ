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
    weak var view: PlayersViewController?
    typealias T = Player
    
    required init(with view: PlayersViewController) {
        self.view = view
        dataManager = DataManager()
    }
    
    func fetch(with service: APIService) {
        self.view?.startLoading()
        dataManager?.get(Player.self, for: service, completion: { results in
            switch results {
            case .success(let collection):
                guard let players = (collection as? [Player])?.filter() else { return }
                let viewModels = players.map({ player -> PlayerViewModel in
                    return PlayerViewModel(with: player)
                })
                DispatchQueue.main.async {
                    self.view?.didSucceed(with: viewModels)
                    self.view?.stopLoading()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.didFail(with: error)
                    self.view?.stopLoading()
                }
            }
        })
    }
    deinit {
        dataManager = nil
    }
}


