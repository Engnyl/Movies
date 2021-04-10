//
//  SessionModel.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import Foundation

// MARK: - SessionModel
struct SessionModel: Codable {
    let success: Bool
    let sessionID: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
