//
//  FavoriteUpdateAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

final class FavoriteUpdateAPIRequest: APIRequest {
    
    init(favoriteUpdateRequestModel: FavoriteUpdateRequestModel) {
        super.init()
        
        super.initAPIRequest(endPoint: String(format: favoriteUpdateURL, getStringPreference(key: ACCOUNT_ID)!),
                             httpMethod: HTTPMethod.post,
                             bodyParameters: [FavoriteUpdateRequestModel.CodingKeys.mediaType.rawValue : favoriteUpdateRequestModel.mediaType,
                                              FavoriteUpdateRequestModel.CodingKeys.mediaID.rawValue : favoriteUpdateRequestModel.mediaID,
                                              FavoriteUpdateRequestModel.CodingKeys.favorite.rawValue : favoriteUpdateRequestModel.favorite],
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
