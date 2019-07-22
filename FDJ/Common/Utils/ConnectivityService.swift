//
//  ConnectivityService.swift
//  FDJ
//
//  Created by Sandy on 2019-07-22.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation

class ConnectivityService {
    var url: URL?
    static let shared = ConnectivityService(url: URL(string: "https://www.google.fr/")!)
    var isOn: Bool = false
    private init(url: URL) {
        self.url = url
        checkConnectivity()
    }
    
    private func checkConnectivity() {
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                self.isOn = true
            }
        }
        task.resume()
    }
}
