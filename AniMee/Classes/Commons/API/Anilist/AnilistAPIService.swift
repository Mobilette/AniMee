//
//  AnilistAPIService.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit
import MBLogger

class AnilistAPIService: AnimeAPIServiceProtocol
{
    // MARK: - Property
    
    static let sharedInstance = AnilistAPIService()
    private lazy var oauthService: OAuthService = AnilistAuthAPIService()
    
    // MARK: - Request
    
    func authorize() -> Promise<AnilistAuthCredential>
    {
        return Promise<AnilistAuthCredential> { fullfil, reject in
            // TODO: probably a bug due to swift compiler
            self.oauthService.authorize().then { credential -> Void in
                fullfil(credential)
            }
                .catch { error -> Void in
                    reject(error)
            }
        }
    }
    
    private func isAuthorized() -> Bool
    {
        return false
    }

    func fetchAnimeEpisodes() -> Promise<String>
    {
        return Promise<String> { fullfil, reject in
            AnilistAPIService.sharedInstance.authorize()
                .then { _ -> Void in
                    AnilistAnimeAPIService.fetchAnimeEpisodes()
                        .then { JSONString -> Void in
                            fullfil(JSONString)
                        }
                        .catch { error -> Void in
                            reject(error)
                    }
                }
                .catch { error -> Void in
                    reject(error)
            }
        }
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