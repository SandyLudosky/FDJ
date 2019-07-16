//
//  ViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ViewProtocol {
    var presenter: HomePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        show()
    }
    
    func setup() {
        presenter = HomePresenter(with: self)
    }
    
    func show() {
        presenter?.fetch(with: .list(.allTeams("English Premier League")))
    }
    
    func startLoading() {}
    
    func stopLoading() {}
   
    
}

extension HomeViewController {
    func didSucceed(with data: [Any]) {
        print(data as? [Team])
    }
    func didFail(with error: Error) {
        print(error.localizedDescription)
    }
}
