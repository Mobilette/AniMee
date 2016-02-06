//
//  RouterProtocol.swift
//  Linkydog
//
//  Created by Romain ASNAR on 01/06/15.
//  Copyright (c) 2015 Linkydog. All rights reserved.
//

import Alamofire

protocol RouterProtocol
{
    var method: Alamofire.Method { get }
    var path: String { get }
    var baseURLString: String { get }
    var OAuthToken: String? { get }
}