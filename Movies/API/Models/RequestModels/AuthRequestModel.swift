//
//  AuthRequestModel.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

// MARK: - AuthRequestModel
struct AuthRequestModel: Codable {
    let username, password, request_token: String?
    
    enum CodingKeys: String, CodingKey {
        case username, password, request_token
    }
}
