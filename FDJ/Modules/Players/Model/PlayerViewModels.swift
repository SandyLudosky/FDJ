//
//  ViewModels.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

struct PlayerViewModel:ViewModelProtocol  {
    typealias T = Player
    var id: String
    var team: String
    var teamId: String
    var name: String
    var thumb: URL?
    var position: String
    var dob: String
    var salary: String
    
    init(with type: Player) {
        self.id = type.idPlayer ?? ""
        self.team = type.strTeam ?? ""
        self.teamId = type.idTeam ?? ""
        self.thumb = type.strCutout != nil ? URL(string: type.strCutout ?? "") :  URL(string: type.strThumb ?? "")
        self.name = type.strPlayer ?? ""
        self.position = type.strPosition ?? ""
        self.dob = type.dateBorn ?? ""
        self.salary = type.strSigning == "" ? "price: Not Specified" : "price: \(type.strSigning ?? "")"
    }
}
