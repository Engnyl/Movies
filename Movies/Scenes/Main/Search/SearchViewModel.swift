//
//  SearchViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 9.04.2021.
//

import UIKit

final class SearchViewModel: SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate?
    
    var numberOfCells: Int {
        return movies.count
    }
    var pageIndex: Int = 1
    var canLoadMore: Bool = false
    
    var moviesFetched: (() ->())?
    
    private var movies: [MovieModel] = [MovieModel]() {
        didSet {
            moviesFetched?()
        }
    }
    
    func loadView() {
        self.notifyViewController(.isLoading(loading: true))
        self.getSession()
    }
    
    func getMovie(at indexPath : IndexPath) -> MovieModel {
        return movies[indexPath.row]
    }
    
    func goMovieInfo(at indexPath : IndexPath) {
        self.navigateViewController(.movieDetail(MovieInfoViewModel(), movies[indexPath.row].id))
    }
    
    func resetQuery() {
        self.pageIndex = 1
        self.canLoadMore = false
        self.movies = [MovieModel]()
    }
    
    func searchMovie(query: String) {
        self.notifyViewController(.isLoading(loading: true))
        
        let searchMovieAPIRequest: SearchMovieAPIRequest = SearchMovieAPIRequest.init(query: query, pageIndex: self.pageIndex)
        searchMovieAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
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
    
    private func getSession() {
        let sessionAPIRequest: SessionAPIRequest = SessionAPIRequest.init(authRequestModel: AuthRequestModel.init(username: nil, password: nil, request_token: getStringPreference(key: REQUEST_TOKEN)))
        sessionAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(SessionModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            registerSessionID(sessionModel: responseObject)
            self.getAccount()
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            invalidateSession()
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func getAccount() {
        let accountAPIRequest: AccountAPIRequest = AccountAPIRequest.init()
        accountAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(AccountModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            registerAccountID(accountModel: responseObject)
            self.notifyViewController(.loadView)
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            invalidateSession()
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func processMovies(movieList: MovieListModel) {
        var movies = [MovieModel]()
        
        for movie in movieList.movies {
            movies.append(movie)
        }
        
        if self.movies.count > 0 {
            self.movies.append(contentsOf: movies)
        }
        else {
            self.movies = movies
        }
    }
    
    private func notifyViewController(_ output: SearchViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    private func navigateViewController(_ route: SearchViewRoute) {
        delegate?.navigate(to: route)
    }
}
