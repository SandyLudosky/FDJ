//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation


struct API {
    static let key = "APIKEY"
}
public enum APIService: APIProtocol {
    
    case search(Search), list(List), lookup(Lookup), schedule(Schedule), image(Image), livescore(LiveScore)
    
    public var baseURL: String {
        switch  self {
        case .search(let endpoint):
            
            switch endpoint {
            case .team(let name, let shortcode):
                if let _ = name {
                    return "https://www.thesportsdb.com/api/v1/json/1/"
                }
                if let _ = shortcode {
                   return "https://www.thesportsdb.com/api/v1/json/\(API.key)/"
                }
            case .players, .event: return "https://www.thesportsdb.com/api/v1/json/1/"
            }
            
        case .list, .lookup, .schedule, .image, .livescore: return "https://www.thesportsdb.com/api/v1/json/1/"
        }
        return ""
    }

    public var endpoint: Endpoint {
        switch self {
        case .search(let service): return service
        case .list(let service): return service
        case .lookup(let service): return service
        case .schedule(let service): return service
        case .image(let service): return service
        case .livescore(let service): return service
        }
    }
    
    public var key: String {
        switch self {
        case .search(let endpoint):
            switch endpoint {
            case .team: return "team"
            case .players: return "player"
            case .event: return "event"
            }
        case .list(let endpoint):
            switch endpoint {
                
            case .allSports: return "sports"
            case .allLeagues: return "leagues"
            case .allSeasons: return "season"
            case .allTeams, .allTeamsDetails: return "teams"
            case .allPlayers: return "player"
            case .allLoves(_): return "players"

            }
        case .lookup(let endpoint):
            switch endpoint {
            case .leagueDetails: return "leagues"
            case .teamDetails: return "teams"
            case .playersDetails: return "players"
            case .eventDetails: return "events"
            case .honours: return "honours"
            case .formerTeams: return "formerteams"
            case .contract: return "contracts"
            case .tvEvent: return "tvevent"
            case .table:  return "table"
            }
        case .schedule(let endpoint):
            switch endpoint {
            case .next5events,  .next15events, .specificEvent: return "events"
            case .last15events, .last5events: return "results"
            case .tvEvents: return "tvevents"
            }
        case .image, .livescore: return ""
        }
    }
}
