//
//  BaseTabBarController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/10.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController{
    
    // Not sure why the first one is not allowed to be BaseCollectionViewController. Buggy!!!
    let viewControllerTypes = [UIViewController.self, TodayController.self, AppsPageController.self, AppsSearchController.self]
    let titles = ["","Today", "Apps", "Search"]
    let imageNames = ["","today_icon", "apps", "search"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewControllers = {
            var controllers = [UIViewController]()
            for index in (0..<titles.count){
                controllers.append(createNavController(viewController: viewControllerTypes[index].init(), title: titles[index], imageName: imageNames[index]))
            }
            controllers.remove(at: 0)
            return controllers
        }()
        
        // default tab
        selectedIndex = 0
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        return navController
    }
}
