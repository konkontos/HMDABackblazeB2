//
//  Configuration.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

public struct B2StorageConfig {
    public init() {}
    
    public let authServerStr = "api.backblazeb2.com"
    
    public var emailAddress: String?
    public var accountId: String?
    public var applicationKey: String?
    public var apiUrl: URL?
    public var downloadUrl: URL?
    public var uploadUrl: URL?
    public var accountAuthorizationToken: String?
    public var uploadAuthorizationToken: String?
    
    public mutating func processAuthorization(jsonStr: String) {
        
        if let jsonData = jsonStr.data(using: .utf8) {
            
            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                
                if let downloadStr = dict["downloadUrl"] as? String {
                    self.downloadUrl = URL(string: downloadStr)
                }
                
                if let apiStr = dict["apiUrl"] as? String {
                    self.apiUrl = URL(string: apiStr)
                }
                
                if let authTokenStr = dict["authorizationToken"] as? String {
                    self.accountAuthorizationToken = authTokenStr
                }
                
                if let accountIdStr = dict["accountId"] as? String {
                    self.accountId = accountIdStr
                }
                
            }
            
        }
        
    }
    
    public mutating func processBucketAuthorization(jsonStr: String) {
        
        if let jsonData = jsonStr.data(using: .utf8) {

            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                if let token = dict["authorizationToken"] as? String {
                    self.accountAuthorizationToken = token
                }
            }
            
        }
        
    }
    
    public mutating func processGetUploadUrl(jsonStr: String) {
        
        if let jsonData = jsonStr.data(using: .utf8) {
            
            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                
                if let uploadUrlStr = dict["uploadUrl"] as? String {
                    self.uploadUrl = URL(string: uploadUrlStr)
                }
                
                if let uploadAuthTokenStr = dict["authorizationToken"] as? String {
                    self.uploadAuthorizationToken = uploadAuthTokenStr
                }
                
            }
            
        }
        
    }
    
    public func firstBucketId(jsonStr: String) -> (bucketId: String, bucketName: String, bucketType: String) {
        
        var bucketInfo = (bucketId:"", bucketName:"", bucketType:"")
        
        if let jsonData = jsonStr.data(using: .utf8) {
            
            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                
                if let buckets = dict["buckets"] as? NSArray {
                    
                    if let firstBucket = buckets[0] as? NSDictionary {
                        bucketInfo.bucketId = (firstBucket["bucketId"] as? String)!
                        bucketInfo.bucketName = (firstBucket["bucketName"] as? String)!
                        bucketInfo.bucketType = (firstBucket["bucketType"] as? String)!
                    }
                    
                }
                
            }
            
        }
        
        return bucketInfo
    }
    
    public func findBucketWithName(searchBucketName: String, jsonStr: String) -> (bucketId: String, bucketName: String, bucketType: String) {
        
        var bucketInfo: (bucketId: String, bucketName: String, bucketType: String) = ("","","")
        
        if let jsonData = jsonStr.data(using: .utf8) {
            
            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                
                if let buckets = dict["buckets"] as? NSArray {
                    
                    for bucket in buckets {
                        
                        let bucketDict = bucket as! NSDictionary
                        
                        if let bucketNameStr = bucketDict["bucketName"] as? String, ((bucketNameStr as NSString).caseInsensitiveCompare(searchBucketName as String) == ComparisonResult.orderedSame)   {
                            bucketInfo.bucketId = (bucketDict["bucketId"] as? String)!
                            bucketInfo.bucketName = (bucketDict["bucketName"] as? String)!
                            bucketInfo.bucketType = (bucketDict["bucketType"] as? String)!
                            break
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return bucketInfo
    }
    
    public func getFileId(jsonStr: String) -> String {
        var fileId = ""
        
        if let jsonData = jsonStr.data(using: .utf8){
            
            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                
                if let fileIdFromDict = dict["fileId"] as? String {
                    fileId = fileIdFromDict
                }
                
            }
            
        }
        
        return fileId
    }
    
    public func findFirstFileIdForName(searchFileName: String, jsonStr: String) -> String {
        var fileId = ""
        
        if let jsonData = jsonStr.data(using: .utf8){
            
            if let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                
                if let files = dict["files"] as? NSArray {
                    
                    for file in files {
                        let fileDict = file as! NSDictionary
                        
                        if let fileName = fileDict["fileName"] as? String, ((fileName as NSString).caseInsensitiveCompare(searchFileName as String) == ComparisonResult.orderedSame)   {
                            fileId = (fileDict["fileId"] as? String)!
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return fileId
    }
    
}
