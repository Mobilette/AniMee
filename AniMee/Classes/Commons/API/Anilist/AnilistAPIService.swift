//
//  AnilistAPIService.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import Alamofire
import OAuthSwift
import PromiseKit

class AnilistAPIService: AnimeAPIServiceProtocol
{
    // MARK: - Property
    
    static let sharedInstance = AnilistAPIService()
    private lazy var oauthService: OAuthService = AnilistAuthAPIService()
    
    // MARK: - Request
    
    func authorize() -> Promise<AnimeAPIServiceSuccessHandler>
    {
        return Promise<AnimeAPIServiceSuccessHandler> { fullfil, reject in
            // TODO: probably a bug due to swift compiler
            self.oauthService.authorize().then { tokenSuccessHandler -> Void in
                fullfil((
                    credential: tokenSuccessHandler.credential,
                    response: tokenSuccessHandler.response,
                    parameters: tokenSuccessHandler.parameters
                ))
            }
                .catch { error -> Void in
                    reject(error)
            }
        }
    }
    
    func handleAuthorizingWithOpenURL(url: NSURL)
    {
        self.oauthService.handleAuthorizingWithOpenURL(url)
    }

    func fetchAnimeEpisodes() -> Promise<String>
    {
        return Promise<String> { fullfil, reject in }
    }

    // MARK: - Type
    
    enum AnilistAPIError
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