//
//  List.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

public enum List: Endpoint {
    case allSports
    case allLeagues
    case allSeasons(leagueId: String)
    case allTeams(leagueName: String)
    case allTeamsDetails(leagueId: String)
    case allPlayers(teamId: String)
    case allLoves(user: String)
    
    public var path: String? {
        switch self {
        case .allSports: return "all_sports.php"
        case .allLeagues: return "all_leagues.php"
        case .allSeasons: return "search_all_seasons.php"
        case .allTeams: return "search_all_teams.php"
        case .allTeamsDetails:  return "lookup_all_teams.php"
        case .allPlayers: return "lookup_all_players.php"
        case .allLoves: return "searchloves.php"
        }
    }
    public var parameters: Dictionary<String, Any>? {
        switch self {
        case .allSports, .allLeagues: break
        case .allSeasons(let id): return ["id": id]
        case .allTeams(let name): return ["l": name]
        case .allTeamsDetails(let id): return ["id": id]
        case .allPlayers(let id): return ["id": id]
        case .allLoves(let user): return ["u": user]
        }
        return [:]
    }
}
