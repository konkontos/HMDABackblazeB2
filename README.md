# HMDABackblazeB2

Backblaze B2 Implementation based on official code.

Currently supporting API v1.

[https://www.backblaze.com/b2/docs/playground.html](https://www.backblaze.com/b2/docs/playground.html)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift 4.x](https://img.shields.io/badge/swift-4.x-orange.svg?style=flat)
![iOS](https://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)


## Build

- clone repo
- generate Xcode project:

        `swift package generate-xcodeproj --xcconfig-overrides Sources/ios.xcconfig`
        
- open Xcode project or build via Carthage

## Usage

- Initialize a `B2StorageConfig` structure with your Backblaze B2 account ID and application key:

        var b2config = B2StorageConfig()

        b2config.accountId = "B2 account ID"
        b2config.applicationKey = "B2 application key"

- Authorize access:

        b2AuthorizeAccount(config: b2Config!) { (jsonStr, error) in

            if error != nil {
                
                // Update your B2 config with data from the authorization response
                self.b2config.processAuthorization(jsonStr: jsonStr!)
                
            } else {

                [handle error]

            }

        )}


- Use your filled-in B2 config structure and B2 bucket ID to call methods on the API:

### File methods

- List files with: b2ListFileNames

- List file versions: b2ListFileVersions

- Get file info: b2GetFileInfo

- Download file: b2DownloadFile

- Delete file version: b2DeleteFileVersion

- Hide file: b2HideFile


### Bucket methods

- List buckets: b2ListBuckets

- Create bucket: b2CreateBucket

- Update bucket: b2UpdateBucket


### File upload methods

- Get upload URL: b2GetUploadUrl

- Upload file: b2UploadFile


## TODO:

- API v2 support

- macOS / Linux compatibility

- tests

- better framework API  / structure
