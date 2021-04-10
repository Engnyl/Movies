//
//  WatchlistUpdateRequestModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

// MARK: - WatchlistUpdateRequestModel
struct WatchlistUpdateRequestModel: Codable {
    let mediaType: String
    let mediaID: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case watchlist
    }
}
