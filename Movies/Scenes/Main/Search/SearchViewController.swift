//
//  SearchViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

final class SearchViewController: SuperViewController {
    
    var viewModel: SearchViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.loadView()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.navigationItem.title = "Search"
        
        super.viewWillAppear(animated)
    }
    
    func prepareView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
    }
}

extension SearchViewController: SearchViewModelDelegate {
    
    func handleViewModelOutput(_ output: SearchViewModelOutput) {
        switch output {
        case .loadView:
            prepareView()
        case .showToastMessage(let message):
            showToastOnCenter(message: message, title: nil, duration: 3.0)
        case .isLoading(let loading):
            loading ? LoadingView.startLoading() : LoadingView.stopLoading()
        case .hideKeyboard:
            dismissKeyboard()
        }
    }
    
    func navigate(to route: SearchViewRoute) {
        switch route {
        case .movieDetail:
            break
        }
    }
}
