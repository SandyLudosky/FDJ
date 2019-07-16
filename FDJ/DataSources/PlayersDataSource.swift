//
//  TeamDataSource.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation
import UIKit

class PlayersDataSource: NSObject {
    var items: [Player]
    init(items: [Player]) {
        self.items = items
        super.init()
    }
    // MARK: - Helper
    func update(with results: [Player]) {
        items = results
    }
    func result(at indexPath: IndexPath) -> Player {
        return items[indexPath.row]
    }
}
// MARK: - UITableDataSource
extension PlayersDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.identifier, for: indexPath) as? PlayerCell else { return UITableViewCell() }
        let player = items[indexPath.row]
        let viewModel = PlayerViewModel(with: player)
        cell.configure(with: viewModel)
        return cell
    }
}

