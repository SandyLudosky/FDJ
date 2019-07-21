//
//  Enums+Service.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

public enum Search {
    case team(name: String?,shortcode: String?)
    case players(team: String?, name: String?)
    case event(name: String?, file: String?)
}

public enum List {
    case allSports
    case allLeagues
    case allSeasons(leagueId: String)
    case allTeams(leagueName: String)
    case allTeamsDetails(leagueId: String)
    case allPlayers(teamId: String)
    case allLoves(user: String)
}

public enum Lookup {
    case leagueDetails(id: String)
    case teamDetails(id: String)
    case playersDetails(id: String)
    case eventDetails(id: String)
    case honours(playerId: String)
    case formerTeams(playerId: String)
    case contract(playerId: String)
    case tvEvent(eventId: String)
    case table(leagueId: String, season: String)
}

public enum Schedule {
    case next5events(id: String)
    case next15events(id: String)
    case last5events(id: String)
    case last15events(id: String)
    case specificEvent(id: String,round: String, season: String)
    case tvEvents(date: String,sport: String?) // create enum for Sport
}

public enum Image {
    case original(url:String), preview(url:String)
}

public enum LiveScore {
    case soccer, golf, basket, football
}


