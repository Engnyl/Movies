//
//  MovieInfoViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import UIKit

final class MovieInfoViewModel: MovieInfoViewModelProtocol {
    var delegate: MovieInfoViewModelDelegate?
    
    func loadView(movieID: Int) {
        self.notifyViewController(.isLoading(loading: true))
        self.getMovieInfo(movieID: movieID)
    }
    
    func watchlistButtonPressed(watchlistUpdateRequestModel: WatchlistUpdateRequestModel) {
        self.notifyViewController(.isLoading(loading: true))
        
        let watchlistUpdateAPIRequest: WatchlistUpdateAPIRequest = WatchlistUpdateAPIRequest.init(watchlistUpdateRequestModel: watchlistUpdateRequestModel)
        watchlistUpdateAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message!))
            self.notifyViewController(.updateWatchlistState(watchlist: watchlistUpdateRequestModel.watchlist))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    func favoriteButtonPressed(favoriteUpdateRequestModel: FavoriteUpdateRequestModel) {
        self.notifyViewController(.isLoading(loading: true))
        
        let favoriteUpdateAPIRequest: FavoriteUpdateAPIRequest = FavoriteUpdateAPIRequest.init(favoriteUpdateRequestModel: favoriteUpdateRequestModel)
        favoriteUpdateAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message!))
            self.notifyViewController(.updateFavoriteState(favorite: favoriteUpdateRequestModel.favorite))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func getMovieInfo(movieID: Int) {
        let movieInfoAPIRequest: MovieInfoAPIRequest = MovieInfoAPIRequest.init(movieID: movieID, language: "en-US")
        movieInfoAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(MovieInfoModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            self.getMovieState(movieID: movieID)
            self.notifyViewController(.loadView(movieInfoModel: responseObject))
            self.notifyViewController(.setTitle(title: responseObject.originalTitle))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func getMovieState(movieID: Int) {
        let getMovieStateAPIRequest: GetMovieStateAPIRequest = GetMovieStateAPIRequest.init(movieID: movieID)
        getMovieStateAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(MovieStateModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            self.notifyViewController(.setButtonState(movieStateModel: responseObject))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func notifyViewController(_ output: MovieInfoViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
