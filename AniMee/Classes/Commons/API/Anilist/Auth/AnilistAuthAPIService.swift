//
//  AnilistAuthAPIService.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import OAuthSwift
import PromiseKit

protocol OAuthService
{
    func authorize() -> Promise<AnilistAuthAPIService.TokenSuccessHandler>
    func handleAuthorizingWithOpenURL(url: NSURL)
}

class AnilistAuthAPIService: OAuthService
{
    typealias TokenSuccessHandler = (credential: OAuthSwiftCredential, response: NSURLResponse?, parameters: NSDictionary)
    
    // MARK: - Request
    
    // MARK: - Property
    
    enum Anilist: String {
        case ConsumerKey    = "romsi94-8mpj9"
        case ConsumerSecret = "Inrp7MrZUx9yTeGgpsA"
        case RedirectURI    = "animee-oauth://oauth-callback/animee"
    }
    
    let oauthService = OAuth2Swift(
        consumerKey:        Anilist.ConsumerKey.rawValue,
        consumerSecret:     Anilist.ConsumerSecret.rawValue,
        authorizeUrl:       "https://anilist.co/api/auth/authorize",
        accessTokenUrl:     "https://anilist.co/api/auth/access_token",
        responseType:       "code"
    )
    
    // MARK: - Authorize
    
    func authorize() -> Promise<AnilistAuthAPIService.TokenSuccessHandler>
    {
        return Promise<AnilistAuthAPIService.TokenSuccessHandler> { fullfil, reject in
            let callbackURL = NSURL(string: Anilist.RedirectURI.rawValue)
            self.oauthService.authorizeWithCallbackURL(
                callbackURL!,
                scope: "",
                state: "",
                params: ["grant_type": "authorization_code"],
                success: { (credential, response, parameters) -> Void in
                    // TODO: handle errors
                    fullfil((credential: credential, response: response, parameters: parameters))
                },
                failure: { (error) -> Void in
                    reject(error)
            })
        }
    }
    
    func handleAuthorizingWithOpenURL(url: NSURL)
    {
        OAuth2Swift.handleOpenURL(url)
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