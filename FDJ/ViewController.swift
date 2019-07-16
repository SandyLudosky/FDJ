//
//  ViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dataManager = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.get(Team.self, for: .list(.allTeams("English Premier League"))) { results in
            switch results {
            case .success(let collection): print(collection)
            case .failure(let error): print(error.description ?? "error")
            }
        }
    }
}


