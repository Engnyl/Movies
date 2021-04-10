//
//  WatchlistUpdateAPIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

final class WatchlistUpdateAPIRequest: APIRequest {
    
    init(watchlistUpdateRequestModel: WatchlistUpdateRequestModel) {
        super.init()
        
        super.initAPIRequest(endPoint: String(format: watchlistUpdateURL, getStringPreference(key: ACCOUNT_ID)!),
                             httpMethod: HTTPMethod.post,
                             bodyParameters: [WatchlistUpdateRequestModel.CodingKeys.mediaType.rawValue : watchlistUpdateRequestModel.mediaType,
                                              WatchlistUpdateRequestModel.CodingKeys.mediaID.rawValue : watchlistUpdateRequestModel.mediaID,
                                              WatchlistUpdateRequestModel.CodingKeys.watchlist.rawValue : watchlistUpdateRequestModel.watchlist],
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
