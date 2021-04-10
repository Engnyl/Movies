//
//  GenericModel.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

// MARK: - GenericModel
struct GenericModel: Codable {
    let success: Bool
    let expiresAt, requestToken, statusMessage: String?
    let statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
