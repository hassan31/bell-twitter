//
//  AppDelegate.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static func app() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        twitterKeysSetting()
        return true
    }
}

// MARK: - Helper Methods
extension AppDelegate {
    
    private func twitterKeysSetting() {
        TWTRTwitter.sharedInstance().start(withConsumerKey:TwitterKeys.consumerKey, consumerSecret:TwitterKeys.consumerSecret)
    }
}

