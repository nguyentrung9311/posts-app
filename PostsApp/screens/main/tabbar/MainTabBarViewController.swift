//
//  TabBarViewController.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 12/06/2023.
//

import UIKit
import ESTabBarController_swift

class MainTabBarViewController: ESTabBarController {
    lazy var vc1: HomeViewController = {
        let viewController = HomeViewController()
        viewController.tabBarItem = ESTabBarItem(
            CustomStyleTabBarContentView(),
            title: "Home",
            image: UIImage(named: "ic_home")
        )
        
        return viewController
    }()
    
    lazy var vc2: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .brown
        viewController.tabBarItem = ESTabBarItem(
            CustomStyleTabBarContentView(),
            title: "Favorite",
            image: UIImage(named: "ic_heart")
        )
        
        return UINavigationController(rootViewController: viewController)
    }()
    
    lazy var vc3: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        viewController.tabBarItem = ESTabBarItem(
            CustomStyleTabBarContentView(),
            title: "Setting",
            image: UIImage(named: "ic_setting")
        )
        
        return UINavigationController(rootViewController: viewController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.4050576985, green: 0.4050576687, blue: 0.4050576687, alpha: 0.3027642863)
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        vc1.rootNavigator = navigationController
    }
}
