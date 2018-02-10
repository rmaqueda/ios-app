//
//  AppDelegate.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // id, first_name, last_name, username, photo_url, auth_date and hash
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("application")
        start()
        UIApplication.shared.statusBarStyle = .lightContent
        //window = UIWindow(frame: UIScreen.main.bounds)
        //window?.makeKeyAndVisible()
        //window?.rootViewController = AuthVC()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Determine who sent the URL.
        let sendingAppID = options[.sourceApplication]
        
        // Process the URL.
        print("application url:", url, sendingAppID!)
        if url.absoluteString.contains("lolkek"){
            let parameters = URLComponents(string: url.absoluteString)
            for item in (parameters?.queryItems)! {
                UserDefaults.standard.set(item.value!, forKey: item.name)
            }
            start()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate")
    }

    func start() {
        if UserDefaults.standard.object(forKey: "id") != nil && UserDefaults.standard.object(forKey: "hash") != nil {
            let hash = UserDefaults.standard.string(forKey: "hash")!
            let id = UserDefaults.standard.integer(forKey: "id")
            let first_name = UserDefaults.standard.string(forKey: "first_name")
            let last_name = UserDefaults.standard.string(forKey: "last_name")
            let username = UserDefaults.standard.string(forKey: "username")
            let photo_url = UserDefaults.standard.string(forKey: "photo_url")
            let sex = UserDefaults.standard.string(forKey: "sex")
            let about = UserDefaults.standard.string(forKey: "about")
            let prof = UserDefaults.standard.string(forKey: "prof")
            let age = UserDefaults.standard.string(forKey: "age")
            
            let user = User(id: id, first_name: first_name, last_name: last_name, username: username, photo_url: photo_url, sex: sex, age: age, prof: prof, about: about)
            UserData.instance.user = user
            UserData.instance.hash = hash
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.rootViewController = NavigationVC()
        }
        else {
            UIApplication.shared.open(URL(string: "http://pluma.me/signin")!, options: [:], completionHandler: nil)
        }
    }
    
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "first_name")
        UserDefaults.standard.removeObject(forKey: "last_name")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "hash")
        UserDefaults.standard.removeObject(forKey: "photo_url")
    }
}

