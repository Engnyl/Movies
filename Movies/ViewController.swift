//
//  ViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth()
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

