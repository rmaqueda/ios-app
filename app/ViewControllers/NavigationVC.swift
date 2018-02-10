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
        let tabOneBarItem = UITabBarItem(title: "News", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
        
        
        // 2
        let tabTwo = UINavigationController(rootViewController: SearchVC())
        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        // 3
        let tabThree = UINavigationController(rootViewController: CnannelsVC())
        let tabThreeBarItem = UITabBarItem(title: "Tab 3", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabThree.tabBarItem = tabThreeBarItem
        
        // 4
        let tabFour = UINavigationController(rootViewController: UserVC(UserData.instance.user!))
        let tabFourBarItem = UITabBarItem(title: "User", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabFour.tabBarItem = tabFourBarItem
        
        
        self.viewControllers = [ tabOne, tabTwo, tabThree, tabFour]
        
        self.moreNavigationController.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected \(viewController.title!)")
    }
}
