//
//  ViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import UIKit

final class LoginViewController: SuperViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.loadView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
        super.viewWillAppear(animated)
    }
    
    func prepareView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [lightBlueColor.cgColor, darkBlueColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        loginButton.backgroundColor = darkBlueColor
        loginViaWebsiteButton.backgroundColor = darkBlueColor
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: UIControl.Event.touchUpInside)
        loginViaWebsiteButton.addTarget(self, action: #selector(loginViaWebsiteButtonTapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let loginRequestModel: LoginRequestModel = LoginRequestModel.init(username: usernameTextField.text, password: passwordTextField.text, request_token: nil)
        viewModel.loginButtonPressed(loginRequestModel: loginRequestModel)
    }
    
    @objc func loginViaWebsiteButtonTapped() {
        let loginRequestModel: LoginRequestModel = LoginRequestModel.init(username: "engnyl", password: "1234", request_token: nil)
        viewModel.loginButtonPressed(loginRequestModel: loginRequestModel)
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
