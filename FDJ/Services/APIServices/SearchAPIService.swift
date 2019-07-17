//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum SearchAPIService: APIProtocol {
    case team(_ name: String?,_ shortcode: String?)
    case players(_ team: String?,_ name: String?)
    case event(_ name: String?,_ file: String?)
    
    public var baseURL: String {
        switch  self {
        case .team(let name, let shortcode):
            if let _ = name {
                return "https://www.thesportsdb.com/api/v1/json/1/"
            }
            if let _ = shortcode {
                return "https://www.thesportsdb.com/api/v1/json/\(API.key)/"
            }
        case .players, .event: return "https://www.thesportsdb.com/api/v1/json/1/"
        }
        return ""
    }
    
    
    public var endpoint: String {
        switch self {
        case .team(_, _): return "searchteams.php"
        case .players(_, _): return "searchplayers.php"
        case .event(let name, let file):
            if let _ = name {
                return "searchevents.php"
            }
            if let _ = file {
                return "searchfilename.php"
            }
        }
        return ""
    }
    
    public var key: String {
        switch self {
        case .team(_, _): return "team"
        case .players(_, _): return "player"
        case .event(_, _): return "event"
        }
    }
    public var httpType: RequestType {
        return .get
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .team(let name, let shortcode):
            if let team = name {
                return ["t": team]
            }
            if let code = shortcode {
                return ["sname": code]
            }
        case .players(let team, let name):
            if let t = team {
                return ["t": t]
            }
            
            if let p = name {
                return ["p": p]
            }
        case .event(let name, let file):
            if let e = name {
                return ["e": e]
            }
            
            if let f = file {
                return ["e": f]
            }
        }
        return nil
    }
}

