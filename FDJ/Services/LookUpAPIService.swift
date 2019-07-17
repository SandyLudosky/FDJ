//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum LookUpAPIService: APIProtocol {
    case leagueDetails(_ id: String)
    case teamDetails(_ id: String)
    case playersDetails(_ id: String)
    case eventDetails(_ id: String)
    case honours(_ playerId: String)
    case formerTeams(_ playerId: String)
    case contract(_ playerId: String)
    case tvEvent(_ eventId: String)
    case table(_ leagueId: String, season: String)
    
    public var baseURL: String {
         return "https://www.thesportsdb.com/api/v1/json/1/"
    }
    
    public var endpoint: String {
        switch self {
        case .leagueDetails: return "lookupleague.php"
        case .teamDetails: return "lookupteam.php"
        case .playersDetails: return "lookupplayer.php"
        case .eventDetails: return "lookupevent.php"
        case .honours: return "lookuphonors.php"
        case .formerTeams: return "lookupformerteams.php"
        case .contract: return "lookupcontracts.php"
        case .tvEvent: return "lookuptv.php"
        case .table: return "lookuptable.php"
        }
    }
    
    public var key: String {
        switch self {
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
    }
    public var httpType: RequestType {
        return .get
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .leagueDetails(let id),
             .teamDetails(let id),
             .playersDetails(let id),
             .eventDetails(let id),
             .honours(let id),
             .formerTeams(let id),
             .contract(let id),
             .tvEvent(let id): return ["id": id]
        case .table(let leagueId, let season):  return ["l": leagueId, "s": season]
        }
    }
}

