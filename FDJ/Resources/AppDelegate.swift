//
//  AppDelegate.swift
//  FDJ
//
//  Created by Sandy on 2019-07-16.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if !NetworkManager.isConnected {
            guard let nav =  window?.rootViewController as? UINavigationController,
                  let vc = nav.viewControllers.first as? HomeViewController,
                  let view = vc.view else { return false }
            view.makeToast(message: ErrorHandler.noNetwork.description ?? "", duration: 1.0, position: .bottom, title: "Error Message", with: .red)
        }
        return true
    }


}

