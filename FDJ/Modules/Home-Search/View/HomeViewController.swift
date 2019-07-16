//
//  ViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ViewProtocol {
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: HomePresenter?
    var dataSource = TeamDataSource(items: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        show()
    }
    
    func setup() {
        presenter = HomePresenter(with: self)
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: TeamCell.identifier, bundle: nil), forCellWithReuseIdentifier: TeamCell.identifier)
    }
    
    func show() {
        presenter?.fetch(with: .list(.allTeams("English Premier League")))
    }
    
    func startLoading() {}
    
    func stopLoading() {}
}

extension HomeViewController {
    func didSucceed(with data: [Any]) {
        guard let teams = data as? [Team] else { return }
        dataSource.update(with: teams)
        collectionView.reloadData()
    }
    func didFail(with error: Error) {
        print(error.localizedDescription)
    }
}
