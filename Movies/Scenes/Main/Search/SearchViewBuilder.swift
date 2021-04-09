//
//  SearchViewBuilder.swift
//  Movies
//
//  Created by Engin Yildiz on 9.04.2021.
//

import UIKit

final class SearchViewBuilder {
    
    static func make(with viewModel: SearchViewModelProtocol) -> SearchViewController {
        let viewController = UIStoryboard.load(.main, identifier: "SearchViewController") as! SearchViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
