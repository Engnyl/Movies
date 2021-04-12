//
//  FavoritesViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit

final class FavoritesViewModel: FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate?
    
    var numberOfCells: Int {
        return movies.count
    }
    var pageIndex: Int = 1
    var canLoadMore: Bool = false
    
    var reloadFavoritesTableViewClosure: (()->())?
    
    private var movies: [MovieModel] = [MovieModel]() {
        didSet {
            self.notifyViewController(.loadView)
        }
    }
    private var cellViewModels: [MovieCellViewModel] = [MovieCellViewModel]() {
        didSet {
            self.reloadFavoritesTableViewClosure?()
        }
    }
    
    func loadView() {
        self.notifyViewController(.isLoading(loading: true))
        self.getFavorites()
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
    
    func resetQuery() {
        self.pageIndex = 1
        self.canLoadMore = false
        self.movies = [MovieModel]()
    }
    
    func getFavorites() {
        let getFavoritesAPIRequest: GetFavoritesAPIRequest = GetFavoritesAPIRequest.init(pageIndex: self.pageIndex)
        getFavoritesAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(MovieListModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            if self.pageIndex < responseObject.totalPages {
                self.canLoadMore = true
                self.pageIndex = self.pageIndex + 1
            }
            else {
                self.canLoadMore = false
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
        
        if self.movies.count > 0 {
            self.movies.append(contentsOf: movies)
        }
        else {
            self.movies = movies
        }
        
        if self.cellViewModels.count > 0 {
            self.cellViewModels.append(contentsOf: cellViewModels)
        }
        else {
            self.cellViewModels = cellViewModels
        }
    }
    
    private func createMovieCellViewModel(movie: MovieModel) -> MovieCellViewModel {
        return MovieCellViewModel(posterPath: movie.posterPath, titleText: movie.title)
    }
    
    private func notifyViewController(_ output: FavoritesViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    private func navigateViewController(_ route: FavoritesViewRoute) {
        delegate?.navigate(to: route)
    }
}
