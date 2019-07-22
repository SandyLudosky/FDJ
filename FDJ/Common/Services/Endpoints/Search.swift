//
//  Search.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


public enum Search: Endpoint {
    case team(name: String?,shortcode: String?)
    case players(team: String?, name: String?)
    case event(name: String?, file: String?)
    
    public var path: String? {
        switch self {
        case .team: return "searchteams.php"
        case .players: return "searchplayers.php"
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
    
    public var parameters: Dictionary<String, Any>? {
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
        return [:]
    }
}
