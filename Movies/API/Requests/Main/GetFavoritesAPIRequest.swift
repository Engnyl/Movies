//
//  GetFavoritesAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import Foundation

final class GetFavoritesAPIRequest: APIRequest {
    
    override init() {
        super.init()
        
        super.initAPIRequest(endPoint: String(format: getFavoritesURL, getStringPreference(key: ACCOUNT_ID)!),
                             httpMethod: HTTPMethod.get,
                             bodyParameters: nil,
                             urlParameters: ["api_key" : APIKey,
                                             "session_id" : getStringPreference(key: SESSION_ID)!])
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
