//
//  AnilistAuthCredential.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/13/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

public class AnilistAuthCredential: NSObject, NSCoding
{
    // MARK: - Property

    var consumer_key: String = String()
    var consumer_secret: String = String()
    public var oauth_token: String = String()
    
    // MARK: - Life cycle
    
    override init() {}

    public init(consumer_key: String, consumer_secret: String, oauth_token: String)
    {
        self.consumer_key = consumer_key
        self.consumer_secret = consumer_secret
        self.oauth_token = oauth_token
    }
    
    // MARK: - Encoding
    
    private struct CodingKeys {
        static let base = NSBundle.mainBundle().bundleIdentifier! + "."
        static let consumerKey = base + "comsumer_key"
        static let consumerSecret = base + "consumer_secret"
        static let oauthToken = base + "oauth_token"
    }
    
    public required convenience init(coder decoder: NSCoder)
    {
        self.init()
        self.consumer_key = (decoder.decodeObjectForKey(CodingKeys.consumerKey) as? String) ?? String()
        self.consumer_secret = (decoder.decodeObjectForKey(CodingKeys.consumerSecret) as? String) ?? String()
        self.oauth_token = (decoder.decodeObjectForKey(CodingKeys.oauthToken) as? String) ?? String()
    }
    
    public func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.consumer_key, forKey: CodingKeys.consumerKey)
        coder.encodeObject(self.consumer_secret, forKey: CodingKeys.consumerSecret)
        coder.encodeObject(self.oauth_token, forKey: CodingKeys.oauthToken)
    }
}