//
//  WatchlistViewBuilder.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit

final class WatchlistViewBuilder {
    
    static func make(with viewModel: WatchlistViewModelProtocol) -> WatchlistViewController {
        let viewController = UIStoryboard.load(.main, identifier: "WatchlistViewController") as! WatchlistViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
