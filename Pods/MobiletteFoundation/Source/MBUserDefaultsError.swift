//
//  MBUserDefaultsError.swift
//  MBError
//
//  Created by Romain ASNAR on 19/11/15.
//  Copyright © 2015 Romain ASNAR. All rights reserved.
//

import Foundation

public enum MBUserDefaultsError: MBError
{
    case Unknown(Int)
    case CanNotSynchronizeUserDefault
    
    public var code: Int {
        switch self {
        case .Unknown:
            return 2000
        case .CanNotSynchronizeUserDefault:
            return 2001
        }
    }
    
    public var domain: String {
        return "NSUserDefaultsDomain"
    }
    
    public var description: String {
        switch self {
        case .Unknown:
            return "Unknown error."
        case .CanNotSynchronizeUserDefault:
            return "Can not synchronize user defaults."
        }
    }
    
    public var reason: String {
        switch self {
        case .Unknown(let status):
            return "An unknown error with status : \(status)."
        case .CanNotSynchronizeUserDefault:
            return "."
        }
    }
}