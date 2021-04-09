//
//  SearchViewContracts.swift
//  Movies
//
//  Created by Engin Yildiz on 9.04.2021.
//

import Foundation

protocol SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate? { get set }
    
    func loadView()
}

enum SearchViewModelOutput {
    case loadView
    case showToastMessage(message: String)
    case isLoading(loading: Bool)
    case hideKeyboard
}

enum SearchViewRoute {
    case movieDetail
}

protocol SearchViewModelDelegate: class {
    func handleViewModelOutput(_ output: SearchViewModelOutput)
    func navigate(to route: SearchViewRoute)
}
