//
//  AnilistAnimeAPIService.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import MBLogger

class AnilistAnimeAPIService
{
    // MARK: - Request

    class func fetchAnimeEpisodes() -> Promise<String>
    {
        return Promise<String> { fullfil, reject in
            let animeRouter = AnimeRouter.Index()
            let request = Alamofire.request(animeRouter)
                .validate()
                .responseString { (request, response, JSONString, error) -> Void in
                    if let statusCode = response?.statusCode {
                        switch statusCode {
                        case 200...299:
                            if let string = JSONString {
                                MBLog.network(MBLog.Level.High, object: "Did fetch anime episodes: \(string).")
                                fullfil(string)
                            }
                            else {
                                let missingDatasError = AnilistAnimeAPIError.MissingData(animeRouter).error
                                MBLog.error(MBLog.Level.High, object: missingDatasError)
                                reject(missingDatasError)
                            }
                        case 401:
                            let unauthorizedError = AnilistAnimeAPIError.Unauthorized(animeRouter).error
                            MBLog.error(MBLog.Level.High, object: unauthorizedError)
                            reject(unauthorizedError)
                        default:
                            if let JSONError = error {
                                MBLog.error(MBLog.Level.High, object: error)
                                reject(JSONError)
                            }
                            else {
                                let missingDatasError = AnilistAnimeAPIError.Unknown(animeRouter).error
                                MBLog.error(MBLog.Level.High, object: missingDatasError)
                                reject(missingDatasError)
                            }
                        }
                    }
            }
        }
    }

    // MARK: - Type
    
    enum AnilistAnimeAPIError
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