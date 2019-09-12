//
//  Files.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

let b2MaxFileCount = 10000

public func b2ListFileNames(config: B2StorageConfig, bucketId: String, startFileName: String?, maxFileCount: Int?, completionHandler: @escaping B2CompletionHandler) {
 
    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_list_file_names"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
 
        var params = "{\"bucketId\":\"\(bucketId)\""
 
        if let startFileStr = startFileName {
            params += ",\"startFileName\":\"\(startFileStr)\""
        }
 
        params += ",\"maxFileCount\":" + String(maxFileCount ?? b2MaxFileCount)
 
        params += "}"
 
        request.httpBody = params.data(using: .utf8, allowLossyConversion: false)
 
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
 
}


public func b2GetFileInfo(config: B2StorageConfig, fileId: String, completionHandler: @escaping B2CompletionHandler) {
    
    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_get_file_info"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = "{\"fileId\":\"\(fileId)\"}".data(using: .utf8, allowLossyConversion: false)
        
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
    
}


public func b2ListFileVersions(config: B2StorageConfig, bucketId: String, startFileName: String?, startFileId: String?, maxFileCount: Int?, completionHandler: @escaping B2CompletionHandler) {
 
    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_list_file_versions"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
 
        var params = "{\"bucketId\":\"\(bucketId)\""
 
        if let startFileNameStr = startFileName {
            params += ",\"startFileName\":\"\(startFileNameStr)\""
        }
 
        if let startFileIdStr = startFileId {
            params += ",\"startFileId\":\"\(startFileIdStr)\""
        }
 
        params += ",\"maxFileCount\":" + String(maxFileCount ?? b2MaxFileCount)
 
        params += "}"
 
        request.httpBody = params.data(using: .utf8, allowLossyConversion: false)
 
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
 
    } else {
        completionHandler(nil,nil)
    }
 
}

public func b2HideFile(config: B2StorageConfig, bucketId: String, fileName: String, completionHandler: @escaping B2CompletionHandler) {
    
    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_hide_file"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = "{\"fileName\":\"\(fileName)\",\"bucketId\":\"\(bucketId)\"}".data(using: .utf8, allowLossyConversion: false)
        
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
    
}



public func b2DeleteFileVersion(config: B2StorageConfig, fileId: String, fileName: String, completionHandler: @escaping B2CompletionHandler) {

    if let url = config.apiUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_delete_file_version"))
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = "{\"fileName\":\"\(fileName)\",\"fileId\":\"\(fileId)\"}".data(using: .utf8, allowLossyConversion: false)
 
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
 
}

