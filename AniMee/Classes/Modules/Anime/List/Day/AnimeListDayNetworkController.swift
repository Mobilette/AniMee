//
//  AnimeListDayNetworkController.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Issouf M'sa Benaly on 9/16/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
// import PromiseKit
// import ObjectMapper

class AnimeListDayNetworkController: AnimeListDayNetworkProtocol
{
    // MARK: - Property
    
    // MARK: - Life cycle

    // MARK: - Network
    
    // MARK: - Error
    
    enum AnimeListDayNetworkControllerError
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