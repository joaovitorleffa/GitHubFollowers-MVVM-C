//
//  AppDelegate.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
        
        return true
    }
}

