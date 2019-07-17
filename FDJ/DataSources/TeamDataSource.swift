//
//  TeamDataSource.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation
import UIKit

class TeamDataSource: NSObject {
    var items: [TeamViewModel]
    init(items: [TeamViewModel]) {
        self.items = items
        super.init()
    }
    // MARK: - Helper
    func update(with results: [TeamViewModel]) {
        items = results
    }
    func result(at indexPath: IndexPath) -> TeamViewModel {
        return items[indexPath.row]
    }
}
// MARK: - UICollectionViewDataSource
extension TeamDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell else {
            return UICollectionViewCell()
        }
        let team = items[indexPath.row]
        cell.configure(with: team)
        return cell
    }
}

