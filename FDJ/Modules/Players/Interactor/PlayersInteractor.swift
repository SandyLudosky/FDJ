//
//  PlayersInteractor.swift
//  FDJ
//
//  Created by Sandy on 2019-10-02.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

class PlayersInteractor: InteractorProtocol {
    var dataManager: DataManager?
    var presenter: PresenterProtocol?
    func fetch(with service: APIService) {
        dataManager?.get(Player.self, for: service, completion: { results in
            switch results {
            case .success(let collection):
                guard let players = collection as? [Player] else { return }
                let viewModels = players.map({player -> PlayerViewModel in
                    return PlayerViewModel(with: player)
                })
                DispatchQueue.main.async {
                    self.presenter?.didSucceed(viewModels)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presenter?.didFail(error)
                }
            }
        })
    }
    deinit {
        dataManager = nil
    }
}

