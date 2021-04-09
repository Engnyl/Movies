//
//  TokenModel.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

struct AuthModel: Codable {
    let success: Bool
    let expires_at, request_token, status_code, status_message: String?
    
    enum CodingKeys: String, CodingKey {
        case success, expires_at, request_token, status_code, status_message
    }
}
