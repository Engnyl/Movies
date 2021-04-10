//
//  MovieInfoViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import UIKit

final class MovieInfoViewModel: MovieInfoViewModelProtocol {
    var delegate: MovieInfoViewModelDelegate?
    
    func loadView(movieID: String) {
        self.notifyViewController(.isLoading(loading: true))
        self.getMovieInfo(movieID: movieID)
    }
    
    private func getMovieInfo(movieID: String) {
        let movieInfoAPIRequest: MovieInfoAPIRequest = MovieInfoAPIRequest.init(movieID: movieID, language: "en-US")
        movieInfoAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(MovieInfoModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            self.notifyViewController(.loadView(movieInfoModel: responseObject))
            self.notifyViewController(.setTitle(title: responseObject.originalTitle))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    func addWatchlistButtonPressed(watchlistUpdateRequestModel: WatchlistUpdateRequestModel) {
        self.notifyViewController(.isLoading(loading: true))
        
        let watchlistUpdateAPIRequest: WatchlistUpdateAPIRequest = WatchlistUpdateAPIRequest.init(watchlistUpdateRequestModel: watchlistUpdateRequestModel)
        watchlistUpdateAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message!))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    func addFavoriteButtonPressed(favoriteUpdateRequestModel: FavoriteUpdateRequestModel) {
        self.notifyViewController(.isLoading(loading: true))
        
        let favoriteUpdateAPIRequest: FavoriteUpdateAPIRequest = FavoriteUpdateAPIRequest.init(favoriteUpdateRequestModel: favoriteUpdateRequestModel)
        favoriteUpdateAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message!))
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
