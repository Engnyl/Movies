//
//  RequestTokenAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import Foundation

final class RequestTokenAPIRequest: APIRequest {
    
    override init() {
        super.init()
        
        super.initAPIRequest(endPoint: requestTokenURL,
                             httpMethod: HTTPMethod.get,
                             bodyParameters: nil,
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
