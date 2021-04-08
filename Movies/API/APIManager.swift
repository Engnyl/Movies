//
//  APIManager.swift
//  Movies
//
//  Created by Engin Yildiz on 7.04.2021.
//

import Foundation
import Alamofire

final class APIManager: NSObject {
    
    static func request(_APIRequest: APIRequest, succeed: @escaping (_ responseData : Data, _ message : String?) -> Void, failed: @escaping (_ message : String) -> Void) {
        switch _APIRequest.httpMethod! {
            
        case HTTPMethod.get:
            AF.request(_APIRequest.endPoint, method: .get, parameters: _APIRequest.bodyParameters ?? nil, encoding: JSONEncoding(), headers: _APIRequest.headers).responseJSON { response in
                guard let responseData = response.data else {
                    failed(ResponseError.serverNoData.rawValue)
                    
                    return
                }
                
                do {
                    let decoded = try JSONSerialization.jsonObject(with: responseData, options: [])
                    
                    if let responseJSON = decoded as? [String : Any] {
                        print(_APIRequest.endPoint!, responseJSON)
                        
                        guard let status: Bool = responseJSON["success"] as? Bool else {
                            failed(ResponseError.serverError.rawValue)
                            
                            return
                        }
                        
                        if status == true {
                            do {
                                let data = try JSONSerialization.data(withJSONObject: responseJSON, options: [])
                                
                                if let message = responseJSON["message"] as? String {
                                    succeed(data, message)
                                }
                                else {
                                    succeed(data, nil)
                                }
                            }
                            catch {
                                failed(error.localizedDescription)
                            }
                        }
                        else {
                            guard let message = responseJSON["message"] as? String else {
                                failed(ResponseError.serverError.rawValue)
                                
                                return
                            }
                            
                            failed(message)
                        }
                    }
                    else {
                        failed(ResponseError.decodingError.rawValue)
                    }
                }
                catch {
                    failed(error.localizedDescription)
                }
            }
            
        case HTTPMethod.post:
            AF.request(_APIRequest.endPoint, method: .post, parameters: _APIRequest.bodyParameters ?? nil, encoding: JSONEncoding(), headers: _APIRequest.headers).responseJSON { response in
                guard let responseData = response.data else {
                    failed(ResponseError.serverNoData.rawValue)
                    
                    return
                }
                
                do {
                    let decoded = try JSONSerialization.jsonObject(with: responseData, options: [])
                    
                    if let responseJSON = decoded as? [String : Any] {
                        print(_APIRequest.endPoint!, responseJSON)
                        
                        guard let status: Bool = responseJSON["success"] as? Bool else {
                            failed(ResponseError.serverError.rawValue)
                            
                            return
                        }
                        
                        if status == true {
                            do {
                                let data = try JSONSerialization.data(withJSONObject: responseJSON, options: [])
                                
                                if let message = responseJSON["message"] as? String {
                                    succeed(data, message)
                                }
                                else {
                                    succeed(data, nil)
                                }
                            }
                            catch {
                                failed(error.localizedDescription)
                            }
                        }
                        else {
                            guard let message = responseJSON["message"] as? String else {
                                failed(ResponseError.serverError.rawValue)
                                
                                return
                            }
                            
                            failed(message)
                        }
                    }
                    else {
                        failed(ResponseError.decodingError.rawValue)
                    }
                }
                catch {
                    failed(error.localizedDescription)
                }
            }
            
        case HTTPMethod.put:
            break
            
        case HTTPMethod.patch:
            break
            
        case HTTPMethod.delete:
            break
        }
    }
}

