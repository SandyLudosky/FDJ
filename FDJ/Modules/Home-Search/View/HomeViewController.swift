//
//  ViewController.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)
    var searchActive: Bool = false
    var presenter: HomePresenter?
    var dataSource: TeamDataSource?


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       presenter?.fetch(with: .list(.allTeams(leagueName: "English Premier League")))
       // presenter?.fetch(with: .lookup(.honours(playerId: "34147178")))
    }
    
    func setup() {
        presenter = HomePresenter(with: self)
        dataSource = TeamDataSource(items: [], self)
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: TeamCell.identifier, bundle: nil), forCellWithReuseIdentifier: TeamCell.identifier)
        configureSearchBar()
        activityIndicator.isHidden = true
        collectionView.showsHorizontalScrollIndicator = false
        print(collectionView.frame.size.width)
        collectionView.set(margin: 2)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: Segue.goToPlayers.string, sender: cell)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}


// MARK: - ViewProtocol
extension HomeViewController: ViewProtocol {
    func show() {
        presenter?.fetch(with: .list(.allTeams(leagueName: seachBarText)))
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func didSucceed(with data: [TeamViewModel]) {
        dataSource?.update(with: data)
        collectionView.reloadData()
    }

    func didFail(with error: ErrorHandler) {
         dataSource?.update(with: [])
         collectionView.reloadData()
         view?.makeToast(message: error.description ?? "No Results", duration: 1.0, position: .bottom, with: .black)
    }
}


// MARK: - UISearchBarDelegate & UISearchResultsUpdating & UISearchControllerDelegate
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {}
    
    var isSeachBarEmpty: Bool {
        return searchController.searchBar.text == ""
    }
    var seachBarText: String {
        guard let text = searchController.searchBar.text else { return "" }
        return text
    }
    
    private func configureSearchBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(HomeViewController.dismissSearchResultsController))

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
        if segue.identifier == Segue.goToPlayers.string {
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
