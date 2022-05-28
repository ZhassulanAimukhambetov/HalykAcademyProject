//
//  AppDelegate.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 23.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ModuleBuilder.shared.tabbarController()
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
