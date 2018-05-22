//
//  MainTabBarController.swift
//  SocialFeed
//
//  Created by Devesh Nema on 5/21/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        
        let feedVC = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        feedNavigationController.tabBarItem.image = #imageLiteral(resourceName: "feed")
        //Add insets to center the tab bar icon (as we are not displaying the icon text with it)
        feedNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0)

        
        let vc2 = createDummyNavController(with: "Videos", image: #imageLiteral(resourceName: "play"))
        let vc3 = createDummyNavController(with: "Market Place", image: #imageLiteral(resourceName: "home"))
        let vc4 = createDummyNavController(with: "Notifications", image: #imageLiteral(resourceName: "bell"))
        let vc5 = createDummyNavController(with: "More", image: #imageLiteral(resourceName: "more"))


        viewControllers = [feedNavigationController, vc2, vc3, vc4, vc5]
        
    }

    func createDummyNavController(with title: String, image: UIImage) -> UINavigationController {
        let controller = UIViewController()
        controller.navigationItem.title = title
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.image = image
        navController.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0)
        return navController
    }

}
