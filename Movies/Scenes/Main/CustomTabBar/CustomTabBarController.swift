//
//  CustomTabBarController.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = darkGrayColor
        self.tabBar.tintColor = darkBlueColor
        
        viewControllers = [SearchViewBuilder.make(with: SearchViewModel())]
    }
}
