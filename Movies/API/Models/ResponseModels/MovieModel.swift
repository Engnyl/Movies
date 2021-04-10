//
//  MovieModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - OriginalLanguage
enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case fr = "fr"
    case ru = "ru"
}
