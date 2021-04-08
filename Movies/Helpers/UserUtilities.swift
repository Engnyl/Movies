//
//  UserUtilities.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

func registerToken(authModel: AuthModel) {
    removePreference(key: REQUEST_TOKEN)
    removePreference(key: REQUEST_TOKEN_EXPIRE)
    
    setPreference(key: REQUEST_TOKEN, value: authModel.request_token)
    setPreference(key: REQUEST_TOKEN_EXPIRE, value: authModel.expires_at)
}
