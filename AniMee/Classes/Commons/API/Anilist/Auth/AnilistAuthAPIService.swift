//
//  AnilistAuthAPIService.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import Security
import MBLogger

protocol OAuthService
{
    func authorize() -> Promise<AnilistAuthCredential>
}

class AnilistAuthAPIService: OAuthService
{
    // MARK: - Request
    
    // MARK: - Property
    
    enum Anilist: String {
        case ConsumerKey    = "romsi94-8mpj9"
        case ConsumerSecret = "Inrp7MrZUx9yTeGgpsA"
        case RedirectURI    = "animee-oauth://oauth-callback/animee"
    }
    
    // MARK: - Authorize
    
    func authorize() -> Promise<AnilistAuthCredential>
    {
        return Promise<AnilistAuthCredential> { fullfil, reject in
            let animeRouter = AnilistAuthRouter.Auth("client_credentials", Anilist.ConsumerKey.rawValue, Anilist.ConsumerSecret.rawValue)
            let request = Alamofire.request(animeRouter)
                .validate()
                .responseJSON { (request, response, JSON, error) -> Void in
                    if let jsonResult = JSON as? [String: AnyObject] {
                        if let accessToken = jsonResult["access_token"] as? String {
                            let anilistAuthCredential = AnilistAuthCredential(consumer_key: Anilist.ConsumerKey.rawValue, consumer_secret: Anilist.ConsumerSecret.rawValue, oauth_token: accessToken)
                            if let error = AnilistAuthAPIService.storeToKeychain(anilistAuthCredential) {
                                println("ERROR !!!!!!!!")
                                reject(error)
                            }
                            fullfil(anilistAuthCredential)
                        }
                    }
            }
        }
    }
    
    // MARK: - Archiving
    
    class func storeToKeychain(credential: AnilistAuthCredential) -> NSError?
    {
        let consumerKey = credential.consumer_key
        let data = NSKeyedArchiver.archivedDataWithRootObject(credential)
        var query = [
            "\(kSecClass)"          : "\(kSecClassGenericPassword)",
            "\(kSecAttrAccount)"    : consumerKey,
            "\(kSecValueData)"      : data
            ] as NSDictionary
        
        SecItemDelete(query as CFDictionaryRef)
        let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
        if status != 0 {
            let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
            MBLog.error(MBLog.Level.High, object: error)
            return error
        }
        MBLog.service(MBLog.Level.High, object: "Stored credential (\(credential)) to Keychain")
        return nil
    }
    
    class func retreiveCredential(consumerKey: String) -> (AnilistAuthCredential?, NSError?)
    {
        var searchQuery = [
            "\(kSecClass)"          : "\(kSecClassGenericPassword)",
            "\(kSecAttrAccount)"    : consumerKey,
            "\(kSecReturnData)"     : true
            ] as NSDictionary
        
        var result :Unmanaged<AnyObject>?
        let status = SecItemCopyMatching(searchQuery, &result)
        if status != 0 {
            let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
            MBLog.error(MBLog.Level.High, object: error)
            return (nil, error)
        }
        if let opaque = result?.toOpaque() {
            let retrievedData = Unmanaged<NSData>.fromOpaque(opaque).takeUnretainedValue()
            var credential = NSKeyedUnarchiver.unarchiveObjectWithData(retrievedData) as? AnilistAuthCredential
            return (credential, nil)
        }
        let badResultsError = AnilistAuthAPIError.Serialization("Can not take unretained value from unmanaged object.").error
        MBLog.error(MBLog.Level.High, object: badResultsError)
        return (nil, badResultsError)
    }
    
    // MARK: - Type
    
    enum AnilistAuthAPIError
    {
        case Unknown(RouterProtocol)
        case Unauthorized(RouterProtocol)
        case MissingData(RouterProtocol)
        case Serialization(AnyObject)
        
        var code: Int {
            switch self {
            case .Unknown:
                return 500
            case .Unauthorized:
                return 401
            case .MissingData:
                return 500
            case .Serialization:
                return 500
            }
        }
        
        var domain: String {
            switch self {
            case .Unknown:
                return "NetworkDomain"
            case .Unauthorized:
                return "UserUnauthorizedDomain"
            case .MissingData:
                return "DataManagementDomain"
            case .Serialization:
                return "DataManagementDomain"
            }
        }
        
        var description: String {
            switch self {
            case .Unknown:
                return "Unknown error."
            case .Unauthorized:
                return "Unauthorized."
            case .MissingData:
                return "Missing datas."
            case .Serialization:
                return "Serialization Error."
            }
        }
        
        var reason: String {
            switch self {
            case .Unknown(let router):
                return "Unknown error at \(router.path)\nRequest server: \(router.path) with \(router.method.rawValue) method."
            case .Unauthorized(let router):
                return "Need to be logged before performing \(router.path)\nRequest server: \(router.path) with \(router.method.rawValue) method."
            case .MissingData(let router):
                return "Response string doesn't contain any known datas.\nRequest server: \(router.path) with \(router.method.rawValue) method."
            case .Serialization(let object):
                return "Can not serialize this object: \(object)."
            }
        }
        
        var error: NSError {
            let userInfo = [
                NSLocalizedDescriptionKey: self.description,
                NSLocalizedFailureReasonErrorKey: self.reason
            ]
            return NSError(domain: self.domain, code: self.code, userInfo: userInfo)
        }
    }
}