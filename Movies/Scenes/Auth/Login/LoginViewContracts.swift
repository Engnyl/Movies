//
//  LoginViewContracts.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

protocol LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate? { get set }
    
    func loadView()
    func loginButtonPressed(loginRequestModel: LoginRequestModel)
}

enum LoginViewModelOutput {
    case loadView
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
}

enum LoginViewRoute {
    case customTabBar
}

protocol LoginViewModelDelegate: class {
    func handleViewModelOutput(_ output: LoginViewModelOutput)
    func navigate(to route: LoginViewRoute)
}
