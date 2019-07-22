//
//  Lookup.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


public enum Lookup: Endpoint {
    case leagueDetails(id: String)
    case teamDetails(id: String)
    case playersDetails(id: String)
    case eventDetails(id: String)
    case honours(playerId: String)
    case formerTeams(playerId: String)
    case contract(playerId: String)
    case tvEvent(eventId: String)
    case table(leagueId: String, season: String)
    public var path: String? {
        switch  self {
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
    
    public var queryItem: Dictionary<String, Any>? {
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
