//
//  MovieInfoAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

final class MovieInfoAPIRequest: APIRequest {
    
    init(movieID: String, language: String) {
        super.init()
        
        super.initAPIRequest(endPoint: String(format: movieInfoURL, movieID),
                             httpMethod: HTTPMethod.get,
                             bodyParameters: nil,
                             urlParameters: ["api_key" : APIKey,
                                             "language" : language])
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
