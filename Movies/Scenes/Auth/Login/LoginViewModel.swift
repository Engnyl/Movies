//
//  LoginViewModel.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

final class LoginViewModel: LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate?
    
    func loadView() {
        self.notifyViewController(.loadView)
    }
    
    func loginButtonPressed(authRequestModel: AuthRequestModel) {
        guard (authRequestModel.username != nil && authRequestModel.username!.count > 0) && (authRequestModel.password != nil && authRequestModel.password!.count > 0) else {
            self.notifyViewController(.showToastMessage(message: "Please enter all the fields."))
            
            return
        }
        
        guard (authRequestModel.username!.count >= 4) else {
            self.notifyViewController(.showToastMessage(message: "Username must be at least 4 characters."))
            
            return
        }
        
        guard (authRequestModel.password!.count >= 4) else {
            self.notifyViewController(.showToastMessage(message: "Password must be at least 4 characters."))
            
            return
        }
        
        self.notifyViewController(.hideKeyboard)
        self.notifyViewController(.isLoading(loading: true))
        self.startAuthentication(authRequestModel: authRequestModel)
    }
    
    func loginViaWebsiteButtonTapped(authRequestModel: AuthRequestModel) {
        self.notifyViewController(.hideKeyboard)
        self.notifyViewController(.isLoading(loading: true))
        self.startAuthentication(authRequestModel: authRequestModel)
    }
    
    private func startAuthentication(authRequestModel: AuthRequestModel) {
        let requestTokenAPIRequest: RequestTokenAPIRequest = RequestTokenAPIRequest.init()
        requestTokenAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(GenericModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                self.notifyViewController(.isLoading(loading: false))
                
                return
            }
            
            self.login(authRequestModel: authRequestModel, requestToken: responseObject.requestToken!)
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }

    private func login(authRequestModel: AuthRequestModel, requestToken: String) {
        let loginAPIRequest: LoginAPIRequest = LoginAPIRequest.init(authRequestModel: AuthRequestModel.init(username: authRequestModel.username, password: authRequestModel.password, request_token: requestToken))
        loginAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(GenericModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            registerToken(genericModel: responseObject)
            
            self.navigateViewController(.customTabBar)
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }
    
    private func notifyViewController(_ output: LoginViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    private func navigateViewController(_ route: LoginViewRoute) {
        delegate?.navigate(to: route)
    }
}
