//
//  Download.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation


public func b2DownloadFile(byID fileId: String, config: B2StorageConfig, andDelegate sessionDelegate: URLSessionDelegate) {

    if let url = config.downloadUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_download_file_by_id"))
 
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["fileId":"\(fileId)"], options: .prettyPrinted)
 
        executeRequest(request: request, withSessionConfig: nil, andDelegate: sessionDelegate)
    }
 
}


public func b2DownloadFile(byID fileId: String, config: B2StorageConfig, completionHandler: @escaping B2DataCompletionHandler) {
 
    if let url = config.downloadUrl {
        var request = URLRequest(url: url.appendingPathComponent("/b2api/v1/b2_download_file_by_id"))
 
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["fileId":"\(fileId)"], options: .prettyPrinted)
 
        executeRequest(request: request, withSessionConfig: nil, completionHandler: completionHandler)
    } else {
        completionHandler(nil,nil)
    }
 
}

