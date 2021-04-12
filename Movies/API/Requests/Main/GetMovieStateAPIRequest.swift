//
//  GetMovieStateAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 12.04.2021.
//

import Foundation

final class GetMovieStateAPIRequest: APIRequest {
    
    init(movieID: Int) {
        super.init()
        
        super.initAPIRequest(endPoint: String(format: getMovieStateURL, String(movieID)),
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

