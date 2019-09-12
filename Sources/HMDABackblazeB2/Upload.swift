//
//  Upload.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

public func b2GetUploadUrl(config: B2StorageConfig, bucketId: String, completionHandler: @escaping B2CompletionHandler) {

    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_get_upload_url"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["bucketId":"\(bucketId)"], options: .prettyPrinted)
        
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
    
}

public func b2UploadFile(config: B2StorageConfig, fileUrl: URL, fileName: String, contentType: String, sha1: String, sessionDelegate: URLSessionDelegate) {
    
    if let url = config.uploadUrl {
        
        var request = URLRequest(url: url.absoluteURL)
        
        request.httpMethod = "POST"
        request.addValue(config.uploadAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.addValue(fileName, forHTTPHeaderField: "X-Bz-File-Name")
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(sha1, forHTTPHeaderField: "X-Bz-Content-Sha1")
        
        executeUploadRequest(request: request, file: fileUrl, withSessionConfig: nil, sessionDelegate: sessionDelegate)
        
    }
    
}


public func b2UploadFile(config: B2StorageConfig, fileUrl: URL, fileName: String, contentType: String, sha1: String, completionHandler: @escaping B2CompletionHandler) {
 
    if let url = config.uploadUrl {

        if let fileData = try? Data(contentsOf: fileUrl.absoluteURL) {
 
            var request = URLRequest(url: url.absoluteURL)
            
            request.httpMethod = "POST"
            request.addValue(config.uploadAuthorizationToken!, forHTTPHeaderField: "Authorization")
            request.addValue(fileName, forHTTPHeaderField: "X-Bz-File-Name")
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
            request.addValue(sha1, forHTTPHeaderField: "X-Bz-Content-Sha1")
 
            executeUploadRequest(request: request,
                                 uploadData: fileData,
                                 withSessionConfig: nil,
                                 completionHandler: completionHandler)
 
        }
 
    } else {
        completionHandler(nil,nil)
    }
 
}
