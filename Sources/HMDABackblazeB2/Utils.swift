//
//  Utils.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

public struct B2File {
    
    public var action: String
    public var accountId: String
    public var bucketId: String
    public var contentLength: Int
    public var contentType: String
    public var fileId: String
    public var contentSha1: String?
    public var fileName: String
    public var size: Int
    public var uploadTimestamp: Double
    
    public static func b2File(from jsonObject: B2JSONObject) -> B2File {
        
        return B2File(action: jsonObject["action"] as! String,
                      accountId: jsonObject["accountId"] as! String,
                      bucketId: jsonObject["bucketId"] as! String,
                      contentLength: jsonObject["contentLength"] as! Int,
                      contentType: jsonObject["contentType"] as! String,
                      fileId: jsonObject["fileId"] as! String,
                      contentSha1: jsonObject["contentSha1"] as? String,
                      fileName: jsonObject["fileName"] as! String,
                      size: jsonObject["size"] as! Int,
                      uploadTimestamp: jsonObject["uploadTimestamp"] as! Double)
    }
    
}

public enum B2BucketType : String {
    case AllPublic = "allPublic"
    case AllPrivate = "allPrivate"
}

public typealias B2CompletionHandler = (String?,Error?) -> Void

public typealias B2DataCompletionHandler = (Data?,Error?) -> Void

public typealias B2JSONObject = [String: Any]

public typealias B2JSONArray = [B2JSONObject]

public extension String {
 
    func toB2JSONObject() -> B2JSONObject? {
     
        if let stringData = self.data(using: .utf8) {
            let jsonObject = try? JSONSerialization.jsonObject(with: stringData, options: .mutableContainers) as! B2JSONObject
            
            return jsonObject
        } else {
            return nil
        }
        
    }
    
    func toB2JSONArray() -> B2JSONArray? {
        
        if let stringData = self.data(using: .utf8) {
            let jsonObject = try? JSONSerialization.jsonObject(with: stringData, options: .mutableContainers) as! B2JSONArray
            
            return jsonObject
        } else {
            return nil
        }
        
    }
 
    var isValidB2AuthorizationResponse: Bool {
     
        if let authObject = self.toB2JSONObject() {
            
            if authObject["authorizationToken"] != nil {
                return true
            } else {
                return false
            }
            
        } else {
            return false
        }
     
    }
    
}

public func b2AuthorizeAccount(config: B2StorageConfig, completionHandler: @escaping B2CompletionHandler) {
    
    if let url = URL(string: "https://\(config.authServerStr)/b2api/v1/b2_authorize_account") {
        
        var request = URLRequest(url: url)
        
        let authStr = "\(config.accountId!):\(config.applicationKey!)"
        
        let authData = authStr.data(using: .utf8)
        
        let base64Str = authData!.base64EncodedString(options: .lineLength76Characters)
        
        request.httpMethod = "GET"
        
        let authSessionConfig = URLSessionConfiguration.default
        authSessionConfig.httpAdditionalHeaders = ["Authorization":"Basic \(base64Str)"]

        executeRequest(request: request, withSessionConfig: authSessionConfig, completionHandler: completionHandler)
        
    } else {
        completionHandler(nil,nil)
    }
    
}

public func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, completionHandler: @escaping B2CompletionHandler) {
    
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        
        if error != nil {
            completionHandler(nil,error)
        } else if data != nil {
            let jsonStr = String(data: data!, encoding: .utf8)
            completionHandler(jsonStr,nil)
        } else {
            completionHandler(nil,nil)
        }
        
    }
    
    task.resume()
}

public func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, completionHandler: @escaping B2DataCompletionHandler) {
    
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        
        if error != nil {
            completionHandler(nil,error)
        } else if data != nil {
            completionHandler(data,nil)
        } else {
            completionHandler(nil,nil)
        }
        
    }
    
    task.resume()
}


public func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, andDelegate sessionDelegate: URLSessionDelegate) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!, delegate: sessionDelegate, delegateQueue: nil)
    } else {
        session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: sessionDelegate, delegateQueue: nil)
    }
    
    let task = session.dataTask(with: request as URLRequest)
    
    task.resume()
}


public func executeUploadRequest(request: URLRequest, uploadData: Data, withSessionConfig sessionConfig: URLSessionConfiguration?, completionHandler: @escaping B2CompletionHandler) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    let task = session.uploadTask(with: request as URLRequest, from: uploadData) { (data, response, error) in
        
        if error != nil {
            completionHandler(nil,error)
        } else if data != nil {
            let jsonStr = String(data: data!, encoding: .utf8)
            completionHandler(jsonStr,nil)
        } else {
            completionHandler(nil,nil)
        }
        
    }
    
    task.resume()
}


public func executeUploadRequest(request: URLRequest, file: URL, withSessionConfig sessionConfig: URLSessionConfiguration?, sessionDelegate: URLSessionDelegate) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!, delegate: sessionDelegate, delegateQueue: nil)
    } else {
        session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: sessionDelegate, delegateQueue: nil)
    }
    
    let task = session.uploadTask(with: request, fromFile: file)
    
    task.resume()
}

