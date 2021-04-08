//
//  UserDefaultsManager.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import Foundation

private let userDefaults = UserDefaults.standard

/* User Defaults */

func setPreference(key: String, value: Any?) {
    userDefaults.set(value, forKey: key)
    userDefaults.synchronize()
}

func getStringPreference(key: String) -> String? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.string(forKey: key)!
    }
    
    return nil
}

func getIntPreference(key: String) -> Int? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.integer(forKey: key)
    }
    
    return nil
}

func getBoolPreference(key: String) -> Bool? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.bool(forKey: key)
    }
    
    return nil
}

func getAnyPreference(key: String) -> Any? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.object(forKey: key)
    }
    
    return nil
}

func removePreference(key: String) {
    userDefaults.removeObject(forKey: key)
    userDefaults.synchronize()
}

func resetPreferences() {
    let domain = Bundle.main.bundleIdentifier!
    userDefaults.removePersistentDomain(forName: domain)
    userDefaults.synchronize()
}
