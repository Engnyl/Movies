//
//  SearchViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 9.04.2021.
//

import UIKit

final class SearchViewModel: SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate?
    
    func loadView() {
        self.notifyViewController(.isLoading(loading: true))
        self.getSession()
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
            self.notifyViewController(.setTitle(title: "Search"))
            
            //self.searchMovie(query: "Hobbit")
            //self.getMovieInfo(movieID: "49051")
            self.navigateViewController(.movieDetail(MovieInfoViewModel()))
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            invalidateSession()
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func searchMovie(query: String) {
        let searchMovieAPIRequest: SearchMovieAPIRequest = SearchMovieAPIRequest.init(query: query)
        searchMovieAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(SearchListModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            print(responseObject)
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func notifyViewController(_ output: SearchViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    private func navigateViewController(_ route: SearchViewRoute) {
        delegate?.navigate(to: route)
    }
}
