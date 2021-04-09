//
//  Extensions.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

/* UIStoryboard */
extension UIStoryboard {
    
    static func load(_ storyboardIdentifier: StoryboardIdentifier, identifier: String? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardIdentifier.rawValue, bundle: nil)
        
        if let identifier = identifier {
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
        else {
            return storyboard.instantiateInitialViewController()!
        }
    }
}
