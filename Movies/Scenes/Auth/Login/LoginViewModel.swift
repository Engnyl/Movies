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
    
    func loginButtonPressed(loginRequestModel: LoginRequestModel) {
        guard (loginRequestModel.username != nil && loginRequestModel.username!.count > 0) && (loginRequestModel.password != nil && loginRequestModel.password!.count > 0) else {
            self.notifyViewController(.showToastMessage(message: "Please enter all the fields."))
            
            return
        }
        
        guard (loginRequestModel.username!.count >= 4) else {
            self.notifyViewController(.showToastMessage(message: "Username must be at least 4 characters."))
            
            return
        }
        
        guard (loginRequestModel.password!.count >= 4) else {
            self.notifyViewController(.showToastMessage(message: "Password must be at least 4 characters."))
            
            return
        }
        
        self.notifyViewController(.hideKeyboard)
        self.notifyViewController(.isLoading(loading: true))
        self.startAuthentication(loginRequestModel: loginRequestModel)
    }
    
    func loginViaWebsiteButtonTapped(loginRequestModel: LoginRequestModel) {
        self.notifyViewController(.hideKeyboard)
        self.notifyViewController(.isLoading(loading: true))
        self.startAuthentication(loginRequestModel: loginRequestModel)
    }
    
    private func startAuthentication(loginRequestModel: LoginRequestModel) {
        let requestTokenAPIRequest: RequestTokenAPIRequest = RequestTokenAPIRequest.init()
        requestTokenAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(AuthModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                self.notifyViewController(.isLoading(loading: false))
                
                return
            }
            
            self.login(loginRequestModel: loginRequestModel, requestToken: responseObject.request_token!)
        }) { [weak self] (message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            self.notifyViewController(.showToastMessage(message: message))
        }
    }

    private func login(loginRequestModel: LoginRequestModel, requestToken: String) {
        let loginAPIRequest: LoginAPIRequest = LoginAPIRequest.init(loginRequestModel: LoginRequestModel.init(username: loginRequestModel.username, password: loginRequestModel.password, request_token: requestToken))
        loginAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(AuthModel.self, from: responseData) else {
                self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                return
            }
            
            registerToken(authModel: responseObject)
            
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
