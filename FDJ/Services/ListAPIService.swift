//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum ListAPIService: APIProtocol {
    case allSports
    case allLeagues
    case allSeasons(_ leagueId: String)
    case allTeams(_ leagueName: String)
    case allTeamsDetails(_ leagueId: String)
    case allPlayers(_ teamId: String)
    case allLoves(_ user: String)
    
    public var baseURL: String {
        return "https://www.thesportsdb.com/api/v1/json/1/"
    }
    
    
    public var endpoint: String {
        switch self {
        case .allSports: return "all_sports.php"
        case .allLeagues: return "all_leagues.php"
        case .allSeasons: return "search_all_seasons.php"
        case .allTeams(_): return "search_all_teams.php" // refacto
        case .allTeamsDetails(_):  return "lookup_all_teams.php"
        case .allPlayers(_): return "lookup_all_players.php"
        case .allLoves(_): return "searchloves.php"
        }
    }
    
    public var key: String {
        switch self {
        case .allSports: return "sports"
        case .allLeagues: return "leagues"
        case .allSeasons(_): return "season"
        case .allTeams, .allTeamsDetails: return "teams"
        case .allPlayers(_): return "player"
        case .allLoves(_): return "players"
        }
    }
    public var httpType: RequestType {
        return .get
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .allSports, .allLeagues: return nil //refacto all leagues in country
        case .allSeasons(let id): return ["id": id]
        case .allTeams(let name): return ["l": name]
        case .allTeamsDetails(let id): return ["id": id]
        case .allPlayers(let id): return ["id": id]
        case .allLoves(let user): return ["u": user]
        }
    }
}

