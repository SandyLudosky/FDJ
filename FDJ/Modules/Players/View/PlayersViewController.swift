//
//  PlayersViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var team: TeamViewModel?
    var interactor: InteractorProtocol?
    lazy var dataSource: PlayersDataSource? = {
        return PlayersDataSource(items: [])
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        show()
    }
    func setup() {
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: PlayerCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerCell.identifier)
        let presenter = PlayersPresenter(with: self)
        interactor = PlayersInteractor()
        interactor?.dataManager = DataManager()
        interactor?.presenter = presenter
        self.title = team?.name
    }
}

// MARK: - ViewProtocol
extension PlayersViewController: ViewProtocol  {
    func show() {
        interactor?.fetch(with: .search(.players(team: team?.name, name: nil)))
    }
    
    func startLoading() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    func didSucceed<VM>(with results: [VM]) where VM : ViewModelProtocol {
        if let data = results as? [PlayerViewModel] {
            dataSource?.update(with: data)
            tableView.reloadData()
        }
    }
    func didFail(with error: ErrorHandler) {
        view.makeToast(message: error.description ?? "", duration: 2.0, position: .bottom, with: .black)
    }
}
