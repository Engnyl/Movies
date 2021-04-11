//
//  FavoritesViewContracts.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate? { get set }
    var numberOfCells: Int { get }
    var reloadFavoritesTableViewClosure: (()->())? { get set }
    
    func loadView()
    func getMovie(at indexPath : IndexPath) -> MovieModel
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel
    func goMovieInfo(at indexPath : IndexPath)
}

enum FavoritesViewModelOutput {
    case loadView
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
}

enum FavoritesViewRoute {
    case movieDetail(MovieInfoViewModelProtocol, Int)
}

protocol FavoritesViewModelDelegate: class {
    func handleViewModelOutput(_ output: FavoritesViewModelOutput)
    func navigate(to route: FavoritesViewRoute)
}
