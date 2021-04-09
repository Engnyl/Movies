//
//  LoginViewBuilder.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

final class LoginViewBuilder {
    
    static func make(with viewModel: LoginViewModelProtocol) -> LoginViewController {
        let viewController = UIStoryboard.load(.auth, identifier: "LoginViewController") as! LoginViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
