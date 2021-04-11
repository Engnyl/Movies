//
//  SearchViewContracts.swift
//  Movies
//
//  Created by Engin Yildiz on 9.04.2021.
//

import Foundation

protocol SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate? { get set }
    var numberOfCells: Int { get }
    var moviesFetched: (() ->())? { get set }
    
    func loadView()
    func getMovie(at indexPath : IndexPath) -> MovieModel
    func goMovieInfo(at indexPath : IndexPath)
    func searchMovie(query: String)
}

enum SearchViewModelOutput {
    case loadView
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
}

enum SearchViewRoute {
    case movieDetail(MovieInfoViewModelProtocol, Int)
}

protocol SearchViewModelDelegate: class {
    func handleViewModelOutput(_ output: SearchViewModelOutput)
    func navigate(to route: SearchViewRoute)
}
