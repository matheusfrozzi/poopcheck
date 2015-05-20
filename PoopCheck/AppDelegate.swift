//
//  AppDelegate.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 22/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()

        // Initialize Parse.
        Parse.setApplicationId("2AUvDjhYywJ3gdwpxUn1F1G9JLJsJcEd73GaXeh1",
            clientKey: "vLg9CIGiCIwXjXkEX9MppE7FDKTD6NBXduXNrwXh")
        
//        PFFacebookUtils.initializeFacebookWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)

        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {

        var currentUser = PFUser.currentUser()

        if let userInfo = userInfo, request = userInfo["request"] as? String {

            UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum);
            var bgTask = UIBackgroundTaskIdentifier()
            bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                

                UIApplication.sharedApplication().endBackgroundTask(bgTask)
                bgTask = UIBackgroundTaskInvalid
            }

            if(request == "newPoop") {
                PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint, error) -> Void in
                    var nPoop = PFObject(className:"Poop")
                    nPoop["user"] = currentUser
                    nPoop["location"] = geoPoint
                    nPoop["localDate"] = NSDate()
                    
                    nPoop.pin()
                    reply(["reply":"new poop"])
                    
                    UIApplication.sharedApplication().endBackgroundTask(bgTask)
                    bgTask = UIBackgroundTaskInvalid
                }
            } else if(request == "getAverage") {
                var poopClass = PoopManager()
                
                poopClass.getPoops(currentUser!.objectId!, callback: { (myArray, error) -> () in
                    if(error == nil) {
                        var sum = 0.0
                        sum =  Double(myArray!.count) / Double(self.betweenDays(UserDefaultsManager.getDateRegister!,date2: NSDate()) + 1)

                        reply(["reply": NSString(format: "%.1f", sum) as String])
                    }
                })
            }
        }
    }
    func betweenDays(date1:NSDate, date2:NSDate) -> Int {
        let startDate:NSDate = date1
        let endDate:NSDate = date2
        
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate: startDate, toDate: endDate, options: nil)
        
        return components.day
    }
}