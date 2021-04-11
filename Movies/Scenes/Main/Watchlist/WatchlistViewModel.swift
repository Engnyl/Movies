//
//  WatchlistViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit

final class WatchlistViewModel: WatchlistViewModelProtocol {
    var delegate: WatchlistViewModelDelegate?
    
    var numberOfCells: Int {
        return movies.count
    }
    
    var reloadWatchlistTableViewClosure: (()->())?
    
    private var movies: [MovieModel] = [MovieModel]() {
        didSet {
            self.notifyViewController(.loadView)
        }
    }
    private var cellViewModels: [MovieCellViewModel] = [MovieCellViewModel]() {
        didSet {
            self.reloadWatchlistTableViewClosure?()
        }
    }
    
    func loadView() {
        self.notifyViewController(.isLoading(loading: true))
        self.getWatchlist()
    }
    
    func getMovie(at indexPath : IndexPath) -> MovieModel {
        return movies[indexPath.row]
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func goMovieInfo(at indexPath : IndexPath) {
        self.navigateViewController(.movieDetail(MovieInfoViewModel(), movies[indexPath.row].id))
    }
    
    private func createMovieCellViewModel(movie: MovieModel) -> MovieCellViewModel {
        return MovieCellViewModel(posterPath: movie.posterPath, titleText: movie.originalTitle)
    }
    
    private func getWatchlist() {
        let getWatchlistAPIRequest: GetWatchlistAPIRequest = GetWatchlistAPIRequest.init()
        getWatchlistAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(MovieListModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            self.processMovies(movieList: responseObject)
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func processMovies(movieList: MovieListModel) {
        var movies = [MovieModel]()
        var cellViewModels = [MovieCellViewModel]()
        
        for movie in movieList.movies {
            movies.append(movie)
            cellViewModels.append(createMovieCellViewModel(movie: movie))
        }
        
        self.movies = movies
        self.cellViewModels = cellViewModels
    }
    
    private func notifyViewController(_ output: WatchlistViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    private func navigateViewController(_ route: WatchlistViewRoute) {
        delegate?.navigate(to: route)
    }
}
