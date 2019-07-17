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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)
    var searchActive: Bool = false
    var presenter: HomePresenter?
    var dataSource: TeamDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
         presenter?.fetch(with: .list(.allTeams("English Premier League")))
    }
    
    func setup() {
        presenter = HomePresenter(with: self)
        dataSource = TeamDataSource(items: [], self)
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: TeamCell.identifier, bundle: nil), forCellWithReuseIdentifier: TeamCell.identifier)
        configureSearchBar()
        activityIndicator.isHidden = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func show() {
        presenter?.fetch(with: .list(.allTeams(seachBarText)))
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "goToPlayers", sender: cell)
    }
}

extension HomeViewController {
    
    func didSucceed(with data: [TeamViewModel]) {
        dataSource?.update(with: data)
        collectionView.reloadData()
    }

    func didFail(with error: ErrorHandler) {
         view?.makeToast(message: error.description ?? "No Results", duration: 1.0, position: .bottom, with: .black)
    }
}

//MARK: UISearchBarDelegate & UISearchResultsUpdating & UISearchControllerDelegate
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    var isSeachBarEmpty: Bool {
        return searchController.searchBar.text == ""
    }
    var seachBarText: String {
        guard let text = searchController.searchBar.text else { return "" }
        return text
    }
    
    private func configureSearchBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(HomeViewController.dismissSearchResultsController))
 
        //navigationItem.rightBarButtonItem = nil
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.placeholder = "Search ..."
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
            searchController.dimsBackgroundDuringPresentation = false
        }
        
        navigationItem.titleView = searchController.searchBar
        navigationItem.rightBarButtonItem = nil
       
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        show()
        searchActive = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        show()
        searchActive = true
    }
  
    @objc func dismissSearchResultsController(_ sender: UIBarButtonItem) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Navigation
extension HomeViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlayers" {
            guard let playersVC = segue.destination as? PlayersViewController else {
                return
            }
            if let cell = sender as? TeamCell, let indexPath = self.collectionView.indexPath(for: cell) {
                let team = dataSource?.result(at: indexPath)
                playersVC.team = team
            }
        }
       
    }
}
