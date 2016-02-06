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
import p2_OAuth2
import MobiletteFoundation

//protocol OAuthService
//{
//    func authorize() -> Promise<AnilistAuthCredential>
//}

protocol OAuth2APIProtocol
{
    func authorize() -> Promise<MBOAuthCredential>
}

class AnilistAuthAPIService: OAuth2APIProtocol
{
    // MARK: - Request
    
    // MARK: - Property
    
    enum Anilist: String {
        case ConsumerKey    = "romsi94-8mpj9"
        case ConsumerSecret = "Inrp7MrZUx9yTeGgpsA"
        case RedirectURI    = "animee-oauth://oauth-callback/animee"
    }
    
    private let oauth2 = OAuth2ClientCredentials(settings: [
        "client_id": Anilist.ConsumerKey.rawValue,
        "client_secret": Anilist.ConsumerSecret.rawValue,
        "authorize_uri": "https://anilist.co/api/auth/authorize", // check if it's the good one
        "token_uri": "https://anilist.co/api/auth/access_token",
        "redirect_uris": [Anilist.RedirectURI.rawValue],
        //"verbose": true,
        "keychain": false
        ] as OAuth2JSON)
    
    func authorize() -> Promise<MBOAuthCredential>
    {
        return Promise<MBOAuthCredential> { [weak self] fullfil, reject in
            let credential: MBOAuthCredential
            do {
                credential = try MBOAuthCredential.retreiveCredential()
            }
            catch _ as MBError {
                self?.performAuthorize()
                    .then { credential -> Void in
                        fullfil(credential)
                    }
                    .error { error in
                        reject(error)
                }
                return
            }
            catch _ {
                let error = MBUserDefaultsError.Unknown(0)
                reject(error.error)
                return
            }
            fullfil(credential)
        }
    }
    
    private func performAuthorize() -> Promise<MBOAuthCredential>
    {
        return Promise<MBOAuthCredential> { fullfil, reject in
            
            oauth2.onAuthorize = { [weak self] parameters in
                if let credential = self?.buildCredential(parameters) {
                    do {
                        try credential.storeToKeychain()
                    }
                    catch let error as MBError {
                        reject(error.error)
                        return
                    }
                    catch _ {
                        let error = MBUserDefaultsError.Unknown(0)
                        reject(error.error)
                        return
                    }
                    fullfil(credential)
                }
                else {
                    // TODO: reject with specific error
                }
            }
            oauth2.onFailure = { error in
                if let error = error {
                    reject(error)
                }
            }
            oauth2.authorize()
        }
    }
    
    private func buildCredential(parameters: OAuth2JSON) -> MBOAuthCredential?
    {
        if let refreshToken = parameters["refresh_token"],
            let accessToken = parameters["access_token"],
            let date = parameters["expires_in"] as? NSDate
        {
            let credential = MBOAuthCredential(userIdentifier: "", accessToken: "\(accessToken)", refreshToken: "\(refreshToken)", expirationDate: date)
            return credential
        }
        return nil
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