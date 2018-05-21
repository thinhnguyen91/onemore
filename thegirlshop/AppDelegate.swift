//
//  AppDelegate.swift
//  thegirlshop
//
//  Created by Thinh Nguyen on 5/11/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
     static let numberFormatter = NumberFormatter()
    
    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let vc = HomeViewController()
        configRootView(vc: vc)
        return true
    }
}

extension AppDelegate {
    private func configStatusBarStyle() {
        
    }
    private func configRootView(vc: UIViewController) {
        let navi = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = navi
    }
}
