//
//  MovieInfoViewBuilder.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import UIKit

final class MovieInfoViewBuilder {
    
    static func make(with viewModel: MovieInfoViewModelProtocol, movieID: Int) -> MovieInfoViewController {
        let viewController = UIStoryboard.load(.main, identifier: "MovieInfoViewController") as! MovieInfoViewController
        viewController.viewModel = viewModel
        viewController.movieID = movieID
        
        return viewController
    }
}
