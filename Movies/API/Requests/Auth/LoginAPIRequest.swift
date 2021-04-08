//
//  LoginAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

final class LoginAPIRequest: APIRequest {
    
    init(loginRequestModel: LoginRequestModel) {
        super.init()
        
        super.initAPIRequest(endPoint: loginTokenURL,
                             httpMethod: HTTPMethod.post,
                             bodyParameters: [LoginRequestModel.CodingKeys.username.rawValue : loginRequestModel.username,
                                              LoginRequestModel.CodingKeys.password.rawValue : loginRequestModel.password,
                                              LoginRequestModel.CodingKeys.request_token.rawValue : loginRequestModel.request_token],
                             urlParameters: ["api_key" : APIKey])
    }
    
    override func APIRequest(succeed: @escaping (_ responseData : Data, _ message : String?) -> Void, failed: @escaping (_ message : String) -> Void) {
        DispatchQueue.main.async {
            APIManager.request(_APIRequest: self, succeed: { (_ responseData : Data, _ message : String?) in
                succeed(responseData, message)
            }, failed: { (_ message : String) in
                failed(message)
            })
        }
    }
}
