//
//  UserUtilities.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

private let dateFormatterString: String = "yyyy-MM-dd H:mm:ss"

func registerToken(authModel: AuthModel) {
    removePreference(key: REQUEST_TOKEN)
    removePreference(key: REQUEST_TOKEN_EXPIRE)
    
    setPreference(key: REQUEST_TOKEN, value: authModel.request_token)
    setPreference(key: REQUEST_TOKEN_EXPIRE, value: authModel.expires_at)
}

func userAuthenticated() -> Bool {
    if getStringPreference(key: REQUEST_TOKEN) != nil &&
        getStringPreference(key: REQUEST_TOKEN_EXPIRE) != nil {
        let expireDateUTC: String = getStringPreference(key: REQUEST_TOKEN_EXPIRE)!.replacingOccurrences(of: " UTC", with: "")
//        let expireDateLocal: String = UTCToLocal(date: getStringPreference(key: REQUEST_TOKEN_EXPIRE)!.replacingOccurrences(of: " UTC", with: ""))!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatterString
        
        if let expireDate = dateFormatter.date(from: expireDateUTC) {
            if expireDate < Date() {
                return true
            }
            
            return false
        }
        
        return false
    }
    
    return false
}

//func UTCToLocal(date: String) -> String? {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = dateFormatterString
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//    if let dateFormatterLocal = dateFormatter.date(from: date) {
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = dateFormatterString
//        return dateFormatter.string(from: dateFormatterLocal)
//    }
//    else {
//        print("There was an error decoding the string")
//        return nil
//    }
//}
