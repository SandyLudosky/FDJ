//
//  HomeSearchTest.swift
//  FDJTests
//
//  Created by Sandy on 2019-07-19.
//  Copyright © 2019 Sandy. All rights reserved.
//

import XCTest
@testable import FDJ
class HomeSearchTest: XCTestCase {
    var client: APIClientMock?
    var view = HomeViewController()
    var presenter: HomePresenter!
    var stub: Stub!
    var teams = [Team]()
    var viewModels = [TeamViewModel]()

    override func setUp() {
        client = APIClientMock(with: .list(.allTeams(leagueName: "English Premier League")))
        presenter = HomePresenter(with: view)
        let stubs = [
            Team(idTeam: "133604", strTeam: "Arsenal", strTeamBadge: ""),
            Team(idTeam: "134430", strTeam: "Arsenal Kyiv", strTeamBadge: "")
        ]
        teams = stubs
        viewModels = teams.map { t -> TeamViewModel in
            return TeamViewModel(with: t)
        }
    }

    func testResultsFound() {
        stub = Stub(teams: viewModels)
        stub.get({ results in
            switch results {
            case .success(_): XCTAssertTrue(true, "results found")
            case .failure(_): XCTAssertTrue(false, "results found")
            }
        })
    }
    
    func testErrorFound() {
        stub = Stub(error: .invalidData)
        stub.get({ results in
            switch results {
            case .success(_): XCTAssertTrue(false, "error found")
            case .failure(_): XCTAssertTrue(true, "error found")
            }
        })
        
    }
}
