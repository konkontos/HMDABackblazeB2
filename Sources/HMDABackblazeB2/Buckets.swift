//
//  Buckets.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

public func b2ListBuckets(config: B2StorageConfig, completionHandler: @escaping B2CompletionHandler) {
    
    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_list_buckets"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["accountId":"\(config.accountId!)"], options: .prettyPrinted)
  
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
    
}


public func b2CreateBucket(bucketName: String, config: B2StorageConfig, completionHandler: @escaping B2CompletionHandler) {
 
    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_create_bucket"))
 
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
 
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["accountId":"\(config.accountId!)", "bucketName":"\(bucketName)", "bucketType":"allPrivate"], options: .prettyPrinted)
 
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
 
}


public func b2UpdateBucket(bucketId: String, bucketType: B2BucketType, config: B2StorageConfig, completionHandler: @escaping B2CompletionHandler) {

    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_update_bucket"))
 
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")

        request.httpBody = "{\"bucketId\":\"\(bucketId)\", \"bucketType\":\"\(bucketType.rawValue)\"}".data(using: .utf8, allowLossyConversion: false)
 
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
 
}

