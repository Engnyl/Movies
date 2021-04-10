//
//  SearchListModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

// MARK: - SearchListModel
struct SearchListModel: Codable {
    let page: Int
    let movies: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
