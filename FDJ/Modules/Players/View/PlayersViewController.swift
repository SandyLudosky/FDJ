//
//  PlayersViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, ViewProtocol {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var team: TeamViewModel?
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
        self.title = team?.name
    }
    
    func show() {
        presenter?.fetch(with: .search(.players(team?.name, nil)))
    }
    
    func startLoading() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}

extension PlayersViewController {
    func didSucceed(with data: [PlayerViewModel]) {
        dataSource.update(with: data)
        tableView.reloadData()
    }

    func didFail(with error: ErrorHandler) {
        view.makeToast(message: error.description ?? "", duration: 2.0, position: .bottom, with: .black)
    }
}
