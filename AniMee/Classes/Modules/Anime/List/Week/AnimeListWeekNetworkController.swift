//
//  AnimeListWeekNetworkController.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper
import MBLogger

class AnimeListWeekNetworkController: AnimeListWeekNetworkProtocol
{
    // MARK: - Property
    
    // MARK: - Life cycle

    // MARK: - Network
    
    func fetchAnimeEpisodes() -> Promise<[AnimeListWeekJSONItem]>
    {
        return Promise<[AnimeListWeekJSONItem]> { fullfil, reject in
            AnilistAPIService.sharedInstance.fetchAnimeEpisodes()
            .then { JSONString -> Void in
                let JSONItem = Mapper<AnimeListWeekJSONItem>().mapArray(JSONString)
                if JSONItem.count > 0 {
                    MBLog.data(MBLog.Level.High, object: "Did map fetch anime episodes JSON response: \(JSONItem).")
                    fullfil(JSONItem)
                }
                else {
                    let mappingError = AnimeListWeekNetworkControllerError.Mapping(JSONString).error
                    MBLog.error(MBLog.Level.High, object: mappingError)
                    reject(mappingError)
                }
            }
            .catch { error -> Void in
                reject(error)
            }
        }
    }
    
    // MARK: - Error
    
    enum AnimeListWeekNetworkControllerError
    {
        case Mapping(String)
        
        var code: Int {
            switch self {
            case .Mapping:
                return 500
            }
        }
        
        var domain: String {
            return "NetworkControllerDomain"
        }
        
        var description: String {
            switch self {
            case .Mapping:
                return "Mapping Error."
            }
        }
        
        var reason: String {
            switch self {
            case .Mapping(let JSONString):
                return "Response string can not be mapped to the object.\nString: \(JSONString)."
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