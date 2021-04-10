//
//  MovieInfoViewContracts.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

protocol MovieInfoViewModelProtocol {
    var delegate: MovieInfoViewModelDelegate? { get set }
    
    func loadView(movieID: Int)
    func addWatchlistButtonPressed(watchlistUpdateRequestModel: WatchlistUpdateRequestModel)
    func addFavoriteButtonPressed(favoriteUpdateRequestModel: FavoriteUpdateRequestModel)
}

enum MovieInfoViewModelOutput {
    case loadView(movieInfoModel: MovieInfoModel)
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
    case setTitle(title: String)
}

protocol MovieInfoViewModelDelegate: class {
    func handleViewModelOutput(_ output: MovieInfoViewModelOutput)
}
