//
//  GetWatchlistAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import Foundation

final class GetWatchlistAPIRequest: APIRequest {
    
    init(pageIndex: Int) {
        super.init()
        
        super.initAPIRequest(endPoint: String(format: getWatchlistURL, getStringPreference(key: ACCOUNT_ID)!),
                             httpMethod: HTTPMethod.get,
                             bodyParameters: nil,
                             urlParameters: ["api_key" : APIKey,
                                             "session_id" : getStringPreference(key: SESSION_ID)!,
                                             "page" : pageIndex])
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
