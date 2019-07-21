//
//  FDJTests.swift
//  FDJTests
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import XCTest
@testable import FDJ

class NetworkAPIClientTests: XCTestCase {
    //unit test
    var homePresenter: HomePresenter? = nil
    
    override func setUp() {
        let view = HomeViewController()
        homePresenter = HomePresenter(with: view)
    }

    func testSearchAPIResponseShouldNotBeNil() {
        homePresenter?.dataManager?.get(Team.self, for: .search(.players(team: "", name: nil)), completion: { results in
            switch results {
            case .success(let data): XCTAssertNil(data, "data should not be nil")
            case .failure(let error): XCTAssertNil(error, "error should be nil")
            }
        })
    }

    func testListAPIResponseShouldNotBeNil() {
        homePresenter?.dataManager?.get(Team.self, for: .list(.allTeams(leagueName: "England Premier League")), completion: { results in
            switch results {
            case .success(let data): XCTAssertNil(data, "response should not be nil")
            case .failure(let error): XCTAssertNil(error, "error should be nil")
            }
        })
    }
    
    func testLookUpAPIResponseShouldNotBeNil() {
        homePresenter?.dataManager?.get(Team.self, for: .lookup(.teamDetails(id: "133604")), completion: { results in
            switch results {
            case .success(let data): XCTAssertNil(data, "response should not be nil")
            case .failure(let error): XCTAssertNil(error, "error should be nil")
            }
        })
    }
}
