//
//  WatchlistViewContracts.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import Foundation

protocol WatchlistViewModelProtocol {
    var delegate: WatchlistViewModelDelegate? { get set }
    var numberOfCells: Int { get }
    var pageIndex: Int { get set }
    var canLoadMore: Bool { get set }
    var reloadWatchlistTableViewClosure: (()->())? { get set }
    
    func loadView()
    func getMovie(at indexPath : IndexPath) -> MovieModel
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel
    func goMovieInfo(at indexPath : IndexPath)
    func resetQuery()
    func getWatchlist()
}

enum WatchlistViewModelOutput {
    case loadView
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
}

enum WatchlistViewRoute {
    case movieDetail(MovieInfoViewModelProtocol, Int)
}

protocol WatchlistViewModelDelegate: class {
    func handleViewModelOutput(_ output: WatchlistViewModelOutput)
    func navigate(to route: WatchlistViewRoute)
}
