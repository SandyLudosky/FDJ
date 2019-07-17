//
//  LeagueViewModel.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype T
    init(with type: T)
}

struct LeagueViewModel: ViewModelProtocol {
    typealias T = League
    
    let id: String
    let league: String
    let sport: String
    let alternate: String
    
    init(with type: League) {
        self.id = type.idLeague
        self.league = type.strLeague
        self.sport = type.strSport
        self.alternate = type.strLeagueAlternate
    }
}

struct TeamViewModel: ViewModelProtocol {
    typealias T = Team
    
    let id: String
    let name: String
    let badge: URL?
    
    init(with type: Team) {
        self.id = type.idTeam
        self.name = type.strTeam
        self.badge = URL(string: type.strTeamBadge)
    }
}
