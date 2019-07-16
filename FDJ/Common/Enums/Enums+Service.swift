//
//  Enums+Service.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

public enum Search {
    case team(_ name: String?,_ shortcode: String?)
    case players(_ team: String?,_ name: String?)
    case event(_ name: String?,_ file: String?)
}

public enum List {
    case allSports
    case allLeagues
    case allSeasons(_ leagueId: String)
    case allTeams(_ leagueName: String)
    case allTeamsDetails(_ leagueId: String)
    case allPlayers(_ teamId: String)
    case allLoves(_ user: String)
}

public enum Lookup {
    case leagueDetails(_ id: String)
    case teamDetails(_ id: String)
    case playersDetails(_ id: String)
    case eventDetails(_ id: String)
    case honours(_ playerId: String)
    case formerTeams(_ playerId: String)
    case contract(_ playerId: String)
    case tvEvent(_ eventId: String)
    case table(_ leagueId: String, season: String)
}

public enum Schedule {
    case next5events(_ id: String)
    case next15events(_ id: String)
    case last5events(_ id: String)
    case last15events(_ id: String)
    case specificEvent(_ id: String,_ round: String,_ season: String)
    case tvEvents(_ date: String,_ sport: String?) // create enum for Sport
}

public enum Image {
    case original(_ url:String), preview(_ url:String)
}

public enum LiveScore {
    case soccer, golf, basket, football
}


