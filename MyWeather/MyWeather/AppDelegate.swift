//
//  AppDelegate.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 11/29/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    static var currentViewController : UIViewController.Type!
    static let rechability = Reachability()!
    static var hasConnectedToInternet : Bool = false
    var window: UIWindow?
    var locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        FIRApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-6162837302788799~1438026268")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
    }


}

