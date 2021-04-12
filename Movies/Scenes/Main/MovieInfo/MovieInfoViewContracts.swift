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
    func watchlistButtonPressed(watchlistUpdateRequestModel: WatchlistUpdateRequestModel)
    func favoriteButtonPressed(favoriteUpdateRequestModel: FavoriteUpdateRequestModel)
}

enum MovieInfoViewModelOutput {
    case loadView(movieInfoModel: MovieInfoModel)
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
    case setTitle(title: String)
    case setButtonState(movieStateModel: MovieStateModel)
    case updateWatchlistState(watchlist: Bool)
    case updateFavoriteState(favorite: Bool)
}

protocol MovieInfoViewModelDelegate: class {
    func handleViewModelOutput(_ output: MovieInfoViewModelOutput)
}
