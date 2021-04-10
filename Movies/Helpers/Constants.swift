//
//  Constants.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

let REQUEST_TOKEN = "request_token"
let REQUEST_TOKEN_EXPIRE = "expires_at"
let SESSION_ID = "session_id"
let ACCOUNT_ID = "id"

let lightBlueColor: UIColor = UIColor(red: 20/255.0, green: 210/255.0, blue: 250/255.0, alpha: 1.0)
let midBlueColor: UIColor = UIColor(red: 10/255.0, green: 100/255.0, blue: 175/255.0, alpha: 1.0)
let darkBlueColor: UIColor = UIColor(red: 8/255.0, green: 52/255.0, blue: 159/255.0, alpha: 1.0)

let lightGrayColor: UIColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
let darkGrayColor: UIColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 1.0)

enum StoryboardIdentifier: String {
    case auth = "Auth"
    case main = "Main"
}
