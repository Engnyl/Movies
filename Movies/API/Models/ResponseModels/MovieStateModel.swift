//
//  MovieStateModel.swift
//  Movies
//
//  Created by Engin Yildiz on 12.04.2021.
//

import Foundation

// MARK: - MovieStateModel
struct MovieStateModel: Codable {
    let id: Int?
    let favorite, rated, watchlist: Bool?
    let statusMessage: String?
    let statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case id, favorite, rated, watchlist
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
