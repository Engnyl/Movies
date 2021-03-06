//
//  LoginAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

final class LoginAPIRequest: APIRequest {
    
    init(authRequestModel: AuthRequestModel) {
        super.init()
        
        super.initAPIRequest(endPoint: loginURL,
                             httpMethod: HTTPMethod.post,
                             bodyParameters: [AuthRequestModel.CodingKeys.username.rawValue : authRequestModel.username!,
                                              AuthRequestModel.CodingKeys.password.rawValue : authRequestModel.password!,
                                              AuthRequestModel.CodingKeys.request_token.rawValue : authRequestModel.request_token!],
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
