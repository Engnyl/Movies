//
//  ViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import UIKit

final class LoginViewController: SuperViewController {
    
    var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.loadView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth()
    }
    
    func prepareView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
    }
    
    @objc func loginButtonTapped() {
        let loginRequestModel: LoginRequestModel = LoginRequestModel.init(username: "Engnyl", password: "1234", request_token: getStringPreference(key: REQUEST_TOKEN)!)
        viewModel.loginButtonPressed(loginRequestModel: loginRequestModel)
    }

    func auth() {
        let requestTokenAPIRequest: RequestTokenAPIRequest = RequestTokenAPIRequest.init()
        requestTokenAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            //self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(AuthModel.self, from: responseData) else {
                //self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                
                showToastOnCenter(message: ResponseError.decodingError.rawValue, title: nil, duration: 3.0)
                
                return
            }
            
            print(responseObject)
            registerToken(authModel: responseObject)
            self.login()
            
            //self.navigateViewController(.customTabBar)
        }) { [weak self] (message) in
            //self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            //self.notifyViewController(.showToastMessage(message: message))
        }
    }

    func login() {
        let loginAPIRequest: LoginAPIRequest = LoginAPIRequest.init(loginRequestModel: LoginRequestModel.init(username: "Engnyl", password: "1234", request_token: getStringPreference(key: REQUEST_TOKEN)!))
        loginAPIRequest.APIRequest(succeed: { [weak self] (responseData, message) in
            //self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            guard let responseObject = try? JSONDecoder().decode(AuthModel.self, from: responseData) else {
                //self.notifyViewController(.showToastMessage(message: ResponseError.decodingError.rawValue))
                
                
                showToastOnCenter(message: ResponseError.decodingError.rawValue, title: nil, duration: 3.0)
                
                return
            }
            
            print(responseObject)
            registerToken(authModel: responseObject)
            
            //self.navigateViewController(.customTabBar)
        }) { [weak self] (message) in
            //self?.notifyViewController(.isLoading(loading: false))
            
            guard let self = self else { return }
            
            //self.notifyViewController(.showToastMessage(message: message))
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func handleViewModelOutput(_ output: LoginViewModelOutput) {
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
    
    func navigate(to route: LoginViewRoute) {
        switch route {
        case .customTabBar:
            let customTabBarController = CustomTabBarBuilder.make()
            let navigationController = UINavigationController(rootViewController: customTabBarController)
            
            let transition = CATransition()
            transition.duration = 0.35
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            navigationController.view.layer.add(transition, forKey: nil)
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController = navigationController
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.makeKeyAndVisible()
        }
    }
}
