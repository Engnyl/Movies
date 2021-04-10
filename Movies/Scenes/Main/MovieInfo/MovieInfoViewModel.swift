//
//  MovieInfoViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import UIKit

final class MovieInfoViewModel: MovieInfoViewModelProtocol {
    var delegate: MovieInfoViewModelDelegate?
    
    func loadView() {
        self.getMovieInfo(movieID: "49051")
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
    
    private func notifyViewController(_ output: MovieInfoViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
