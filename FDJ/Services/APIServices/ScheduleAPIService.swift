//
//  ScheduleAPIService.swift
//  FDJ
//
//  Created by Sandy on 2019-07-17.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

public enum ScheduleAPIService: APIProtocol {
    case next5events(_ id: String)
    case next15events(_ id: String)
    case last5events(_ id: String)
    case last15events(_ id: String)
    case specificEvent(_ id: String,_ round: String,_ season: String)
    case tvEvents(_ date: String,_ sport: String?) // create enum for Sport
    
    public var baseURL: String {
       return "https://www.thesportsdb.com/api/v1/json/1/"
    }
    
    public var endpoint: String {
        switch self {
            
        case .next5events: return "eventsnext.php"
        case .next15events: return "eventsnextleague.php"
        case .last5events: return "eventslast.php"
        case .last15events: return "eventspastleague.php"
        case .specificEvent: return "eventsround.php"
        case .tvEvents: return "eventstv.php"
        }
    }
    
    public var key: String {
        switch self {
        case .next5events,  .next15events, .specificEvent: return "events"
        case .last15events, .last5events: return "results"
        case .tvEvents: return "tvevents"
        }
    }
    public var httpType: RequestType {
        return .get
    }
    
    public var parameters: [String : Any]? {
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
