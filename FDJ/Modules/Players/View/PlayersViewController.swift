//
//  PlayersViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, ViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    var team: Team?
    var presenter: PlayersPresenter?
    var dataSource = PlayersDataSource(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        show()
    }
    func setup() {
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: PlayerCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerCell.identifier)
        presenter = PlayersPresenter(with: self)
        self.title = team?.strTeam
    }
    
    func show() {
        presenter?.fetch(with: .search(.players(team?.strTeam, nil)))
    }
    
    func startLoading() {
        print("loading")
    }
    
    func stopLoading() {
         print("stop loading")
    }
}

extension PlayersViewController {
    func didSucceed(with data: [Any]) {
        guard let players = data as? [Player] else { return }
        dataSource.update(with: players)
        tableView.reloadData()
    }
    func didFail(with error: Error) {
        print(error.localizedDescription)
    }
}
