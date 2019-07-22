//
//  Livescore.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation


public enum LiveScore: Endpoint {
    case soccer, golf, basket, football
    
    public var path: String? {
        switch self {
        case .soccer: return "latestsoccer.php"
        case .golf: return "latestgolf.php"
        case .basket: return "atestbasketball.php"
        case .football: return  "latestamericanfootball.php"
        }
    }
    
    public var parameters: Dictionary<String, Any>? {
        return nil
    }
}

