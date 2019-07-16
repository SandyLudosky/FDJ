//
//  LeagueViewModel.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

struct LeagueViewModel {
    let id: String
    let league: String
    let sport: String
    let alternate: String
    
    init(with league: League) {
        self.id = league.idLeague
        self.league = league.strLeague
        self.sport = league.strSport
        self.alternate = league.strLeagueAlternate
    }
}

struct TeamViewModel {
    let id: String
    let name: String
    let badge: URL?
    
    init(with team: Team) {
        self.id = team.idTeam
        self.name = team.strTeam
        self.badge = URL(string: team.strTeamBadge) 
    }
}
