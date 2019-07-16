//
//  FDJTests.swift
//  FDJTests
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import XCTest
@testable import FDJ

class FDJTests: XCTestCase {
    var homePresenter: HomePresenter? = nil
    
    override func setUp() {
        let view = HomeViewController()
        homePresenter = HomePresenter(with: view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataShouldNotBeNil() {
        homePresenter?.dataManager?.get(Team.self, for: .list(.allTeams("England Premier League")), completion: { results in
            switch results {
                
            case .success(let data): XCTAssertNil(data, "data should not be nil")
            case .failure(let error): XCTAssertNil(error, "error should be nil")
            }
        })
    }

}
