//
//  MBOAuthCredential.swift
//  MBOAuthCredential
//
//  Created by Romain ASNAR on 19/11/15.
//  Copyright © 2015 Romain ASNAR. All rights reserved.
//

import Foundation
import Security

public class MBOAuthCredential: NSObject, NSCoding
{
    // MARK: - Type
    
    private struct CodingKeys {
        static let base = NSBundle.mainBundle().bundleIdentifier! + "."
        static let userIdentifier = base + "user_identifier"
        static let accessToken = base + "access_token"
        static let expirationDate = base + "expiration_date"
        static let refreshToken = base + "refresh_token"
    }
    
    // MARK: - Property
    
    public var userIdentifier: String? = nil
    
    public var token: String? {
        if self.isExpired() {
            return nil
        }
        return self.accessToken
    }
    
    public var refreshToken: String? = nil
    
    public var expirationDate: NSDate? = nil
    
    public var archivedOAuthCredential: NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    private var accessToken: String? = nil
    
    // MARK: - Life cycle
    
    public init(userIdentifier: String,
        accessToken: String,
        refreshToken: String,
        expirationDate: NSDate? = nil
        )
    {
        self.userIdentifier = userIdentifier
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expirationDate = expirationDate
    }
    
    // MARK: - NSCoding protocol
    
    @objc required public init?(coder decoder: NSCoder)
    {
        self.userIdentifier = decoder.decodeObjectForKey(CodingKeys.userIdentifier) as? String
        self.accessToken = decoder.decodeObjectForKey(CodingKeys.accessToken) as? String
        self.expirationDate = decoder.decodeObjectForKey(CodingKeys.expirationDate) as? NSDate
        self.refreshToken = decoder.decodeObjectForKey(CodingKeys.refreshToken) as? String
    }
    
    @objc public func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.userIdentifier, forKey: CodingKeys.userIdentifier)
        coder.encodeObject(self.accessToken, forKey: CodingKeys.accessToken)
        coder.encodeObject(self.expirationDate, forKey: CodingKeys.expirationDate)
        coder.encodeObject(self.refreshToken, forKey: CodingKeys.refreshToken)
    }
    
    // MARK: - Archiving
    
    public func storeToKeychain() throws
    {
        guard let userIdentifier = self.userIdentifier,
            let _ = self.accessToken,
            let _ = self.refreshToken
            else {
                throw MBOAuthCredentialError.BadCredentials
        }
        
        let query = [
            "\(kSecClass)"          : "\(kSecClassGenericPassword)",
            "\(kSecAttrAccount)"    : userIdentifier,
            "\(kSecValueData)"      : self.archivedOAuthCredential
            ] as NSDictionary
        
        let secItemDeleteStatus = SecItemDelete(query as CFDictionaryRef)
        if secItemDeleteStatus != noErr && secItemDeleteStatus != errSecItemNotFound {
            throw MBOAuthCredentialError.Unknown(Int(secItemDeleteStatus))
        }
        
        let secItemAddStatus = SecItemAdd(query as CFDictionaryRef, nil)
        if secItemAddStatus != noErr {
            throw MBOAuthCredentialError.Unknown(Int(secItemAddStatus))
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(userIdentifier, forKey: "mb_user_identifier")
        
        let synchronizeResult = userDefaults.synchronize()
        if synchronizeResult == false {
            throw MBUserDefaultsError.CanNotSynchronizeUserDefault
        }
    }
    
    public class func retreiveCredential(
        userIdentifier userIdentifier: String? = nil
        ) throws -> MBOAuthCredential
    {
        let identifier: String
        if let _userIdentifier = userIdentifier {
            identifier = _userIdentifier
        }
        else {
            guard let _userIdentifier = self.userIdentifierFromNSUserDefaults() else {
                throw MBOAuthCredentialError.UserIdentifierMissing
            }
            identifier = _userIdentifier
        }
        
        let searchQuery = [
            "\(kSecClass)"          : "\(kSecClassGenericPassword)",
            "\(kSecAttrAccount)"    : identifier,
            "\(kSecReturnData)"     : true
            ] as NSDictionary
        
        var result: AnyObject?
        let secItemCopyStatus = SecItemCopyMatching(searchQuery, &result)
        if secItemCopyStatus != noErr {
            throw MBOAuthCredentialError.Unknown(Int(secItemCopyStatus))
        }
        guard let retrievedData = result as? NSData else {
            throw MBOAuthCredentialError.CanNotCopy
        }
        guard let credential = NSKeyedUnarchiver.unarchiveObjectWithData(retrievedData) as? MBOAuthCredential else {
            throw MBOAuthCredentialError.CanNotUnarchiveObject
        }
        return credential
    }
    
    private class func userIdentifierFromNSUserDefaults() -> String?
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let identifier = userDefaults.objectForKey("mb_user_identifier") as? String {
            return identifier
        }
        return nil
    }
    
    // MARK: - Authentication
    
    public func isAuthenticated() -> Bool
    {
        let hasAccessToken = (self.accessToken != nil)
        return (hasAccessToken) && (!self.isExpired())
    }
    
    public func isExpired() -> Bool
    {
        if let expirationDate = self.expirationDate {
            let today = NSDate()
            let isExpired = (expirationDate.compare(today) == NSComparisonResult.OrderedAscending)
            return isExpired
        }
        return false
    }
}

public enum MBOAuthCredentialError: MBError
{
    case Unknown(Int)
    case BadCredentials
    case BadResults()
    case UserIdentifierMissing
    case CanNotUnarchiveObject
    case CanNotCopy
    
    public var code: Int {
        switch self {
        case .Unknown:
            return 1000
        case .BadCredentials:
            return 1001
        case .BadResults:
            return 1002
        case .UserIdentifierMissing:
            return 1003
        case .CanNotUnarchiveObject:
            return 1004
        case .CanNotCopy:
            return 1005
        }
    }
    
    public var domain: String {
        return "OAuthCredentialDomain"
    }
    
    public var description: String {
        switch self {
        case .Unknown:
            return "Unknown error."
        case .BadCredentials:
            return "Bad credentials."
        case .BadResults:
            return "Bad results."
        case .UserIdentifierMissing:
            return "User identifier missing"
        case .CanNotUnarchiveObject:
            return "Can not unarchive object."
        case .CanNotCopy:
            return "Can not copy."
        }
    }
    
    public var reason: String {
        switch self {
        case .Unknown(let status):
            return "Security function throw error with status : \(status)."
        case .BadCredentials:
            return ""
        case .BadResults:
            return ""
        case .UserIdentifierMissing:
            return ""
        case .CanNotUnarchiveObject:
            return ""
        case .CanNotCopy:
            return ""
        }
    }
}