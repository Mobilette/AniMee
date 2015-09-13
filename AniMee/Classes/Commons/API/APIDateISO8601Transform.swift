//
//  APIDateISO8601Transform.swift
//  Linkydog
//
//  Created by Romain ASNAR on 9/13/15.
//  Copyright (c) 2015 AniMee. All rights reserved.
//

import Foundation
import ObjectMapper

public class APIDateISO8601Transform: TransformType
{
    public typealias Object = NSDate
    public typealias JSON = String
    private static var dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Object?
    {
        if let time = value as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = APIDateISO8601Transform.dateFormat
            return dateFormatter.dateFromString(time)
        }
        return nil
    }
    
    public func transformToJSON(value: NSDate?) -> JSON?
    {
        if let date = value {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = APIDateISO8601Transform.dateFormat
            return dateFormatter.stringFromDate(date)
        }
        return nil
    }
}