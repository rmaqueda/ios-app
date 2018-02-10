//
//  NavigationVC.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class NavigationVC: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hash", UserData.instance.hash!)
        if UserData.instance.user != nil {
            print("id", UserData.instance.user!.id)
            print("username", UserData.instance.user!.username ?? "")
            print("first_name", UserData.instance.user!.first_name ?? "")
            print("last_name", UserData.instance.user!.last_name ?? "")
            print("photo_url", UserData.instance.user!.photo_url ?? "")
        }
        delegate = self
        setupViews()
    }
    
    func setupViews(){
        UINavigationBar.appearance().barTintColor = .main
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        self.tabBar.tintColor = .main
        
        
        // 1
        let tabOne = UINavigationController(rootViewController: NewsVC())
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // 2
        let tabTwo = UINavigationController(rootViewController: SearchVC())
        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        // 3
        let tabThree = UINavigationController(rootViewController: NewsVC())
        let tabThreeBarItem = UITabBarItem(title: "Tab 3", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabThree.tabBarItem = tabThreeBarItem
        
        // 4
        let tabFour = UINavigationController(rootViewController: SearchVC())
        let tabFourBarItem = UITabBarItem(title: "Tab 4", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabFour.tabBarItem = tabFourBarItem
        
        // 5
        let tabFive = UINavigationController(rootViewController: NewsVC())
        let tabFiveBarItem = UITabBarItem(title: "Tab 5", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabFive.tabBarItem = tabFiveBarItem
        
        // 6
        let tabSix = UINavigationController(rootViewController: SearchVC())
        let tabSixBarItem = UITabBarItem(title: "Tab 6", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabSix.tabBarItem = tabSixBarItem
        
        
        
        self.viewControllers = [ tabOne, tabTwo, tabThree, tabFour, tabFive, tabSix]
        
        self.moreNavigationController.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected \(viewController.title!)")
    }
}
