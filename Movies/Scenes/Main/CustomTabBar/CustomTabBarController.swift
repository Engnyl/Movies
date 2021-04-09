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
        
        viewControllers = [SearchViewBuilder.make(with: SearchViewModel())]
    }
}
