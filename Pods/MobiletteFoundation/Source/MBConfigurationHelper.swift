//
//  MBConfigurationHelper.swift
//  MBConfigurationHelper
//
//  Created by Romain ASNAR on 19/11/15.
//  Copyright © 2015 Romain ASNAR. All rights reserved.
//

import Foundation

public class MBConfigurationHelper
{
    public class func configuration(fileKey: String, key: String) -> String?
    {
        if let configuration = MBConfigurationHelper.configurationFile(fileKey) {
            return configuration.objectForKey(key) as? String
        }
        return nil
    }
    
    public class func configurationFile(fileKey: String) -> NSDictionary?
    {
        let file = NSBundle.mainBundle().objectForInfoDictionaryKey(fileKey) as? String
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
}