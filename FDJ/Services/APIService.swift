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
    
    public var endpoint: String {
        switch self {
       
        case .search(let endpoint):
            switch endpoint {
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
        case .list(let endpoint):
            switch endpoint {
                
            case .allSports: return "all_sports.php"
            case .allLeagues: return "all_leagues.php"
            case .allSeasons: return "search_all_seasons.php"
            case .allTeams(_): return "search_all_teams.php" // refacto
            case .allTeamsDetails(_):  return "lookup_all_teams.php"
            case .allPlayers(_): return "lookup_all_players.php"
            case .allLoves(_): return "searchloves.php"
            }
        case .lookup(let endpoint):
            switch endpoint {
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
        case .schedule(let endpoint): //refacto
            switch endpoint {
            case .next5events: return "eventsnext.php"
            case .next15events: return "eventsnextleague.php"
            case .last5events: return "eventslast.php"
            case .last15events: return "eventspastleague.php"
            case .specificEvent: return "eventsround.php"
            case .tvEvents: return "eventstv.php"
            }
        case .image(let endpoint):
            switch endpoint {
            case .original(let url): return url
            case .preview(let url): return "\(url)/preview"
            }
        case .livescore(let endpoint):
            switch endpoint {
                
            case .soccer: return "latestsoccer.php"
            case .golf: return "latestgolf.php"
            case .basket: return "atestbasketball.php"
            case .football: return  "latestamericanfootball.php"
            }

        }
        return ""
    }
    
    public var key: String {
    
        switch self {

        case .search(let endpoint):
            switch endpoint {
            case .team(_, _): return "team"
            case .players(_, _): return "player"
            case .event(_, _): return "event"
            }
        case .list(let endpoint):
            switch endpoint {
                
            case .allSports: return "sports"
            case .allLeagues: return "leagues"
            case .allSeasons(_): return "season"
            case .allTeams, .allTeamsDetails: return "teams"
            case .allPlayers(_): return "player"
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
    public var httpType: RequestType {
        return .get
    }

    public var parameters: [String : Any]? {
        switch self {
       
        case .search(let endpoint):
            switch endpoint {
                
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
        case .list(let endpoint):
            switch endpoint {
                
            case .allSports, .allLeagues: return nil //refacto all leagues in country
            case .allSeasons(let id): return ["id": id]
            case .allTeams(let name): return ["l": name]
            case .allTeamsDetails(let id): return ["id": id]
            case .allPlayers(let id): return ["id": id]
            case .allLoves(let user): return ["u": user]
            }
        case .lookup(let endpoint):
            switch endpoint {
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
        case .schedule(let endpoint):
            switch endpoint {
                
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
        case .image(let endpoint):
            switch endpoint {
                case .original, .preview: return nil
            }
        case .livescore(let endpoint):
            switch endpoint {
            case .soccer, .golf, .basket, .football: return nil
            }
        }
        return nil
    }
}
