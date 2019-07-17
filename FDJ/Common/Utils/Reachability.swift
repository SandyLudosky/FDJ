//
//  Reachability.swift
//  HenriPotierSwift
//
//  Created by Sandy on 2019-06-12.
//  Copyright © 2019 Sandy. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability: Reachability!
    static var isConnected: Bool {
        if (NetworkManager.shared.reachability).connection != .none {
            return true
        }
        return false
    }
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    private override init() {
        super.init()
        // Initialise reachability
        reachability = Reachability()!
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.shared.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection != .none {
            completed(NetworkManager.shared)
        }
    }
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .none {
            completed(NetworkManager.shared)
        }
    }
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .cellular {
            completed(NetworkManager.shared)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .wifi {
            completed(NetworkManager.shared)
        }
    }
}
