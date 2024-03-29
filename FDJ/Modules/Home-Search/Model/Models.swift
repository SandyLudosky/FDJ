//
//  Team.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

class League: Decodable {
    let idLeague: String
    let strLeague: String
    let strSport: String
    let strLeagueAlternate: String
}

struct Team: Decodable {
    let idTeam: String
    let strTeam: String
    let strTeamBadge: String
}

