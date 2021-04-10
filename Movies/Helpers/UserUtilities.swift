//
//  UserUtilities.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

private let dateFormatterString: String = "yyyy-MM-dd H:mm:ss"

func registerToken(genericModel: GenericModel) {
    removePreference(key: REQUEST_TOKEN)
    removePreference(key: REQUEST_TOKEN_EXPIRE)
    
    setPreference(key: REQUEST_TOKEN, value: genericModel.requestToken)
    setPreference(key: REQUEST_TOKEN_EXPIRE, value: genericModel.expiresAt)
}

func registerSessionID(sessionModel: SessionModel) {
    removePreference(key: SESSION_ID)
    setPreference(key: SESSION_ID, value: sessionModel.sessionID)
}

func registerAccountID(accountModel: AccountModel) {
    removePreference(key: ACCOUNT_ID)
    setPreference(key: ACCOUNT_ID, value: accountModel.accountID)
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

func invalidateSession() {
    removePreference(key: REQUEST_TOKEN)
    removePreference(key: REQUEST_TOKEN_EXPIRE)
    removePreference(key: SESSION_ID)
    removePreference(key: ACCOUNT_ID)
    
    let loginViewController = LoginViewBuilder.make(with: LoginViewModel())
    let navigationController = UINavigationController(rootViewController: loginViewController)
    
    let transition = CATransition()
    transition.duration = 0.35
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    navigationController.view.layer.add(transition, forKey: nil)
    
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController = navigationController
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.makeKeyAndVisible()
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
