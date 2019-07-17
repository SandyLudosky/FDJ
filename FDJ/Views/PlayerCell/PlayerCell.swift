//
//  PlayerCell.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit
import SDWebImage

class PlayerCell: UITableViewCell {
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    static let identifier = "PlayerCell"
    
    func configure(with viewModel: PlayerViewModel) {
        containerView.layer.cornerRadius = 10.0
        containerView.layer.masksToBounds = true
        self.playerImageView.sd_setImage(with: viewModel.thumb)
        self.playerNameLabel.text = viewModel.name
        self.positionLabel.text = viewModel.position
        self.dobLabel.text = viewModel.dob
        self.priceLabel.text = viewModel.salary
    }
}
