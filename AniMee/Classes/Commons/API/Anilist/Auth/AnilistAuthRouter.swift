//
//  AnilistAuthRouter.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/13/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum AnilistAuthRouter:
    RouterProtocol,
    URLRequestConvertible,
    Printable
{
    var baseURLString: String {
        return "https://anilist.co/api"
    }
    var OAuthToken: String? {
        return nil
    }
    
    case Auth(String, String, String)
    
    var method: Alamofire.Method {
        switch self {
        case .Auth:
            return .POST
        }
    }

    var model: String {
        return "auth"
    }
    
    var path: String {
        switch self {
        case .Auth:
            return "/\(model)/access_token"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: "\(self.baseURLString)\(path)")
        let mutableURLRequest = NSMutableURLRequest(URL: URL!)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .Auth(let grantType, let clientID, let clientSecret):
            let JSONParameters = ["grant_type": grantType, "client_id": clientID, "client_secret": clientSecret]
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: JSONParameters).0
        }
    }

    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnilistAuthRouter" + "\n"
            + "baseURLString: \(self.baseURLString)" + "\n"
            + "OAuthToken: \(self.OAuthToken)" + "\n"
            + "method: \(self.method.rawValue)" + "\n"
            + "path: \(self.path)" + "\n"
            + "}" + "\n"
    }
}