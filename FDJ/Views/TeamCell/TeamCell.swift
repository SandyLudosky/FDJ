//
//  TeamCell.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit
import SDWebImage

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var badgeImageView: UIImageView!
    static let identifier = "TeamCell"
   
    func configure(with viewModel: TeamViewModel) {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        badgeImageView.sd_setImage(with: viewModel.badge)
    }
}
