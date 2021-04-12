//
//  APIConstants.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import Foundation

let APIKey = "d25f167dc622630d04929091478b7aa3"
let baseURL = "https://api.themoviedb.org/3"
let imageBaseURL = "https://image.tmdb.org/t/p/w500"

let requestTokenURL = "/authentication/token/new?"
let loginURL = "/authentication/token/validate_with_login?"
let newSessionURL = "/authentication/session/new?"
let accountURL = "/account?"
let searchMovieURL = "/search/movie?"
let movieInfoURL = "/movie/%@?"
let getWatchlistURL = "/account/%@/watchlist/movies?"
let watchlistUpdateURL = "/account/%@/watchlist?"
let getFavoritesURL = "/account/%@/favorite/movies?"
let favoriteUpdateURL = "/account/%@/favorite?"
let getMovieStateURL = "/movie/%@/account_states?"

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum ResponseError : String {
    case serverNoData = "No data from server error. Please try again."
    case serverError = "Server error. Please try again."
    case decodingError = "Decoding error. Please try again."
}

enum HTTPHeaderField: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case token = "token"
}

enum ContentType: String {
    case json = "application/json"
}
