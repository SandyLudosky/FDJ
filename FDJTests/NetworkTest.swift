//
//  NetworkTest.swift
//  FDJTests
//
//  Created by Sandy on 2019-07-19.
//  Copyright © 2019 Sandy. All rights reserved.
//

import XCTest
@testable import FDJ

class NetworkTest: XCTestCase {
    //unit tests to verify API Client response, .success and .error

    var client: APIClientMock?
    
    override func setUp() {
       // client = APIClientMock(with: .list(.allTeams(leagueName: "English Premier League")) )
        
        client = APIClientMock(with: .lookup(.honours(playerId: "4147178")))
    }
    

    
    func testAPIClientSuccessfulResponse() {
        guard let url = client?.service?.request?.url else {
              return
        }
        let task = client?.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                if let dataOK = data {
                    XCTAssertNotNil(dataOK, "response successful")
                }
            }
        })
        task?.resume()
    }
}
