//
//  Schedule.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

public enum Schedule: Endpoint {
    case next5events(id: String)
    case next15events(id: String)
    case last5events(id: String)
    case last15events(id: String)
    case specificEvent(id: String,round: String, season: String)
    case tvEvents(date: String,sport: String?)
    
    public var path: String? {
        switch self {
        case .next5events: return "eventsnext.php"
        case .next15events: return "eventsnextleague.php"
        case .last5events: return "eventslast.php"
        case .last15events: return "eventspastleague.php"
        case .specificEvent: return "eventsround.php"
        case .tvEvents: return "eventstv.php"
        }
    }
    
    public var queryItem: Dictionary<String, Any>? {
        switch self {
        case .next5events(let id),
             .next15events(let id),
             .last5events(let id),
             .last15events(let id): return ["id": id]
        case .specificEvent(let id, let round, let season): return ["id": id, "r": round, "s": season]
        case .tvEvents(let date, let sport):
            if let s = sport {
                return ["d": date, "s": s]
            }
            return ["d": date]
        }
    }
}


