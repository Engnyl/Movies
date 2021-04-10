//
//  FavoriteUpdateRequestModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

// MARK: - FavoriteUpdateRequestModel
struct FavoriteUpdateRequestModel: Codable {
    let mediaType: String
    let mediaID: Int
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
}
