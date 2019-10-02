//
//  HomeInteractor.swift
//  FDJ
//
//  Created by Sandy on 2019-10-02.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

class HomeInteractor: InteractorProtocol {
    var dataManager: DataManager?
    var presenter: PresenterProtocol?
    func fetch(with service: APIService) {
        dataManager?.get(Team.self, for: service, completion: { results in
            switch results {
            case .success(let collection):
                guard let teams = collection as? [Team] else { return }
                let viewModels = teams.map({ team -> TeamViewModel in
                    return TeamViewModel(with: team)
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

