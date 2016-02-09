//
//  ImageRouter.swift
//  Linkydog
//
//  Created by Romain ASNAR on 12/06/15.
//  Copyright (c) 2015 Linkydog. All rights reserved.
//

import Foundation
import Alamofire

enum ImageRouter: RouterProtocol, URLRequestConvertible
{
    var baseURLString: String { return "" }
    var OAuthToken: String? { return nil }
    
    case FetchImage(NSURL)
    
    var method: Alamofire.Method {
        switch self {
        case .FetchImage:
            return .GET
        }
    }
    
    var path: String {
        return ""
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL())
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .FetchImage(let URL):
            mutableURLRequest.URL = URL
            return mutableURLRequest
        }
    }
}