//
//  APIRequest.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import Foundation
import Alamofire

public typealias HTTPBodyParameters = [String : Any]?
public typealias HTTPUrlParameters = [String : Any]?

class APIRequest: NSObject {
    var endPoint: String!
    var httpMethod: HTTPMethod!
    var bodyParameters: HTTPBodyParameters?
    var urlParameters: HTTPUrlParameters?
    lazy var headers: HTTPHeaders = [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
                                     ContentType.json.rawValue: HTTPHeaderField.accept.rawValue]
    
    func initAPIRequest(endPoint: String, httpMethod: HTTPMethod, bodyParameters: HTTPBodyParameters?, urlParameters: HTTPUrlParameters?) {
        self.endPoint = baseURL + endPoint
        self.httpMethod = httpMethod
        self.bodyParameters = bodyParameters
        self.urlParameters = urlParameters
        
        setUrlParameters()
    }
    
    func APIRequest(succeed: @escaping (_ responseData : Data, _ message : String?) -> Void, failed: @escaping (_ message : String) -> Void) {}
    
    private func setUrlParameters() {
        guard urlParameters != nil else {
            return
        }
        
        var index = 0
        
        for (key, value) in urlParameters!! {
            endPoint.append(key)
            endPoint.append("=")
            endPoint.append(String(describing: value))
            
            if index < urlParameters!!.count - 1 {
                index = index + 1
                endPoint.append("&")
            }
        }
    }
}
