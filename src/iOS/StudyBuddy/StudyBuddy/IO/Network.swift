//
//  Network.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/16/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation
import AFNetworking

typealias successCallback = (_ response: Any?) -> Void
typealias failureCallback = (_ error: Error) -> Void

final class Network2 {
    static let sharedInstance = Network2()
    private var sharedManager: AFHTTPSessionManager
    private init() {
        sharedManager = AFHTTPSessionManager(baseURL: URL(string: kBaseURL))
        sharedManager.responseSerializer = AFJSONResponseSerializer()
        sharedManager.securityPolicy.allowInvalidCertificates = true
        sharedManager.securityPolicy.validatesDomainName = false
    }
    func sendRequestToURL(url: URL, parameters: Dictionary<String, String>?, success: @escaping successCallback, failure: @escaping failureCallback) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        sharedManager.post(url.absoluteString, parameters: parameters, progress: nil, success: { (_, response) in
            success(response)
        }) { (_, error) in
            failure(error)
        }
    }
}


