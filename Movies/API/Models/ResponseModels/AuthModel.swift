//
//  TokenModel.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

// MARK: - AuthModel
struct AuthModel: Codable {
    let success: Bool
    let expiresAt, requestToken, statusCode, statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
