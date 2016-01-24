//
//  MBRouterProtocol.swift
//  MBRouterProtocol
//
//  Created by Romain ASNAR on 19/11/15.
//  Copyright © 2015 Romain ASNAR. All rights reserved.
//

import Foundation
import Alamofire

public protocol RouterProtocol: CustomStringConvertible
{
    var version: String { get }
    var baseURLStringFromConfiguration: String? { get }
    var baseURLString: String? { get }
    var OAuthToken: String? { get }
    var method: Alamofire.Method { get }
    var path: String { get }
    var baseURLRequest: NSMutableURLRequest { get }
}

extension RouterProtocol
{
    public var version: String {
        return "v1"
    }
    
    public var baseURLStringFromConfiguration: String? {
        return MBConfigurationHelper.configuration("WEB_SERVICE_BASE_URL", key: "API_URL")
    }
    
    public var baseURLString: String? {
        if let baseURLStringFromConfiguration = self.baseURLStringFromConfiguration {
            return "\(baseURLStringFromConfiguration)/api/\(self.version)"
        }
        return nil
    }
    
    public var OAuthToken: String? {
        let credentials: MBOAuthCredential
        do {
            credentials = try MBOAuthCredential.retreiveCredential()
        } catch _ {
            return nil
        }
        return credentials.token
    }
    
    public var baseURLRequest: NSMutableURLRequest {
        guard let baseURLString = self.baseURLString else {
            fatalError("Router must have a valid base URL (\(self.baseURLString)).")
        }
        guard let URL = NSURL(string: baseURLString) else {
            fatalError("Can not initialize an URL (\(baseURLString)).")
        }
        
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(self.path))
        mutableURLRequest.HTTPMethod = self.method.rawValue
        
        if let token = self.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return mutableURLRequest
    }
    
    // MARK: - Printable protocol
    
    public var description: String {
        return "{ RouterProtocol" + "\n"
            + "baseURLString: \(self.baseURLString)" + "\n"
            + "OAuthToken: \(self.OAuthToken)" + "\n"
            + "method: \(self.method.rawValue)" + "\n"
            + "path: \(self.path)" + "\n"
            + "}" + "\n"
    }
}