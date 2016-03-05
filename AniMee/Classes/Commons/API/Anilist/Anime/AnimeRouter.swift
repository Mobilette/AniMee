//
//  AnimeRouter.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum AnimeRouter:
    RouterProtocol,
    URLRequestConvertible,
    CustomStringConvertible
{
    var baseURLString: String {
        return "https://sleepy-falls-90290.herokuapp.com/api"
    }
    var OAuthToken: String? {
        //        if let credentials = AnilistAuthAPIService.retreiveCredential(AnilistAuthAPIService.Anilist.ConsumerKey.rawValue).0 {
        //            return credentials.oauth_token
        //        }
        return nil
    }
    
    case Index()
    
    var method: Alamofire.Method {
        switch self {
        case .Index:
            return .GET
        }
    }

    var model: String {
        return "anime"
    }
    
    var path: String {
        switch self {
        case .Index:
            return "/\(model)/from/today"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: "\(self.baseURLString)\(path)")
        let mutableURLRequest = NSMutableURLRequest(URL: URL!)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
//        case .Create(let JSONItem):
//            let JSONParameters = Mapper().toJSON(JSONItem)
//            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: JSONParameters).0
//        case .Update(_, let JSONItem):
//            let JSONParameters = Mapper().toJSON(JSONItem)
//            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: JSONParameters).0
        default:
            return mutableURLRequest
        }
    }

    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeRouter" + "\n"
            + "baseURLString: \(self.baseURLString)" + "\n"
            + "OAuthToken: \(self.OAuthToken)" + "\n"
            + "method: \(self.method.rawValue)" + "\n"
            + "path: \(self.path)" + "\n"
            + "}" + "\n"
    }
}