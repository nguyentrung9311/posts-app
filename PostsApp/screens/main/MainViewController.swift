//
//  MainViewController.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 15/06/2023.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableViewFrame: UIView!
    @IBOutlet weak var homeTab: UIView!
    @IBOutlet weak var favoriteTab: UIView!
    @IBOutlet weak var settingTab: UIView!
    
    var viewControllers = [UIViewController]()
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initPages()
    }
    
    private func initTabs() {
        favoriteTab.layer.opacity = 0.2
        settingTab.layer.opacity = 0.2
    }
    
    private func initPages() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        addChild(pageViewController)
        tableViewFrame.addSubview(pageViewController.view)
        
        pageViewController.view.frame = tableViewFrame.bounds
        
        let homeViewController = HomeViewController()
        homeViewController.rootNavigator = navigationController
        
        viewControllers = [
            homeViewController
        ]
        
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let pageControl = UIPageControl()
        pageControl.isHidden = true
    }
}

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewControllers.firstIndex(of: pageViewController)
        
        if index == nil || index == 0 { return nil }
        else {
            index! -= 1
            if index == 0 { return nil }
            return viewControllers[index!]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = viewControllers.firstIndex(of: pageViewController)
        
        if index == nil { return nil }
        else {
            index! += 1
            if index == viewControllers.count { return nil }
            return viewControllers[index!]
        }
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return viewControllers.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
}
