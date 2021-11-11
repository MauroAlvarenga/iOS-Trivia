//
//  TabBarViewController.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 03/11/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        let firstTabTitle = "Categories"
        let firstTabImage = UIImage(systemName: "list.dash")
        
        let firstTabViewController = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        firstTabViewController.title = firstTabTitle
        
        let firstTabNavigationController = UINavigationController(rootViewController: firstTabViewController)
        let firstTabBarItem = UITabBarItem(title: firstTabTitle, image: firstTabImage, selectedImage: nil)
        firstTabNavigationController.tabBarItem = firstTabBarItem
        
        let secondTabTitle = "Random"
        let secondTabImage = UIImage(systemName: "shuffle")
        
        let secondTabViewController = QuestionViewController(nibName: "QuestionViewController", bundle: nil)
        secondTabViewController.title = secondTabTitle
        
        let secondTabNavigationController = UINavigationController(rootViewController: secondTabViewController)
        let secondTabBarItem = UITabBarItem(title: secondTabTitle, image: secondTabImage, selectedImage: nil)
        secondTabNavigationController.tabBarItem = secondTabBarItem
        
        setNavBarAppeareance(firstTabNavigationController.navigationBar)
        setNavBarAppeareance(secondTabNavigationController.navigationBar)
        setTabBarAppeareance(self.tabBar)
        
        viewControllers = [secondTabNavigationController, firstTabNavigationController]
    }
    
    func setNavBarAppeareance(_ navbar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.darkText, .font: UIFont(name: "Futura", size: 28)!]
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
        navbar.compactAppearance = appearance
    }

    func setTabBarAppeareance(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        appearance.compactInlineLayoutAppearance.normal.iconColor = .darkText
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.darkText, .font: UIFont(name: "Futura", size: 12)!]
        
        appearance.inlineLayoutAppearance.normal.iconColor = .darkText
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.darkText, .font: UIFont(name: "Futura", size: 12)!]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .darkText
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.darkText, .font: UIFont(name: "Futura", size: 12)!]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = .systemBlue
    }
}
