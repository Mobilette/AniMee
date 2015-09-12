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
    Printable
{
    var baseURLString: String {
        return "https://anilist.co/api"
    }
    var OAuthToken: String? {
        if let credentials = AnilistAuthAPIService.retreiveCredential(AnilistAuthAPIService.Anilist.ConsumerKey.rawValue).0 {
            return credentials.oauth_token
        }
        return nil
    }
    
    case Index()
//    case Create(AnimeCreationJSONItem)
//    case Read(String)
//    case Update(String, AnimeUpdateJSONItem)
//    case Destroy(String)
    
    var method: Alamofire.Method {
        switch self {
        case .Index:
            return .GET
//        case .Create:
//            return .POST
//        case .Read:
//            return .GET
//        case .Update:
//            return .PUT
//        case .Destroy:
//            return .DELETE
        }
    }

    var model: String {
        return "anime"
    }
    
    var path: String {
        switch self {
        case .Index:
            return "/browse/\(model)?status=Currently%20Airing&airing_data=true&full_page=true"
//        case .Create:
//            return "/\(model)/"
//        case .Read(let id):
//            return "/\(model)/\(id)/"
//        case .Update(let id, _):
//            return "/\(model)/\(id)"
//        case .Destroy(let id):
//            return "/\(model)/\(id)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSURLRequest {
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