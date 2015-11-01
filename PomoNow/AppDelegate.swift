//
//  AppDelegate.swift
//  PomoNow
//
//  Created by Megabits on 15/9/16.
//  Copyright (c) 2015年 ScrewBox. All rights reserved.
//

import UIKit
import CoreData


var isFirst = true
var isDisableLockScreen = true
var pomodoroClass = pomodoro()
//GTD相关，每次只做一件事
var withTask = false

//数据结构
var task = [[String]]()

//colors
let colorRed = UIColor(red: 255/255, green: 121/255, blue: 100/255, alpha: 1)
let colorYellow = UIColor(red: 255/255, green: 188/255, blue: 103/255, alpha: 1)
let colorBlue = UIColor(red: 155/255, green: 193/255, blue: 224/255, alpha: 1)
let colorPink = UIColor(red: 226/255, green: 128/255, blue: 228/255, alpha: 1)
let colorGray = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
let taskColor = UIColor(red: 202/255, green: 105/255, blue: 105/255, alpha: 1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

