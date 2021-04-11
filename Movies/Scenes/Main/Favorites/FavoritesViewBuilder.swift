//
//  FavoritesViewBuilder.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit

final class FavoritesViewBuilder {
    
    static func make(with viewModel: FavoritesViewModelProtocol) -> FavoritesViewController {
        let viewController = UIStoryboard.load(.main, identifier: "FavoritesViewController") as! FavoritesViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
