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
    
    var view: HomeViewController?
    var dataManager: DataManager?
    typealias T = Team
  
    required init(with view: HomeViewController) {
        self.view = view
        dataManager = DataManager()
    }
    
    func fetch(with service: APIService) {
        self.view?.startLoading()
        dataManager?.get(Team.self, for: service, completion: { results in
            switch results {
            case .success(let collection):
                guard let teams = collection as? [Team] else { return }
                let viewModels = teams.map({ team -> TeamViewModel in
                    return TeamViewModel(with: team)
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
    
}
