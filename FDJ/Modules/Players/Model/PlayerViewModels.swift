//
//  ViewModels.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

struct PlayerViewModel {
    var id: String
    var team: String
    var teamId: String
    var name: String
    var thumb: URL?
    var position: String
    var dob: String
    var salary: String
    
    init(with player: Player) {
        self.id = player.idPlayer
        self.team = player.strTeam
        self.teamId = player.idTeam
        self.thumb = URL(string: player.strThumb)
        self.name = player.strPlayer
        self.position = player.strPosition
        self.dob = player.dateBorn
        self.salary = "price: \(player.strSigning)"
    }
}
