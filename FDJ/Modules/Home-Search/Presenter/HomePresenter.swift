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
    var dataManager: DataManager?
    var view: ViewProtocol?
    typealias T = Team

    required init(with view: ViewProtocol) {
        self.view = view
        dataManager = DataManager()
    }
    
    func fetch(with service: APIService) {
        self.view?.startLoading()
        dataManager?.get(Team.self, for: service, completion: { results in
            switch results {
            case .success(let collection):
                guard let teams = collection as? [Team] else { return }
                DispatchQueue.main.async {
                    self.view?.didSucceed(with: teams)
                    self.view?.stopLoading()
                }
            case .failure(let error): self.view?.didFail(with: error)
            }
        })
    }
    
}
