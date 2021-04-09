//
//  CustomTabBarBuilder.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

final class CustomTabBarBuilder {
    
    static func make() -> CustomTabBarController {
        let tabBarController = UIStoryboard.load(.main, identifier: "CustomTabBarController") as! CustomTabBarController
        
        return tabBarController
    }
}
