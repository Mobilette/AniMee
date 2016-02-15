//
//  AnimeAPIServiceProtocol.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit
import MobiletteFoundation

protocol AnimeAPIServiceProtocol
{
    static func fetchAnimeEpisodes() -> Promise<String>
}

extension AnimeAPIServiceProtocol {
    private static func methodNotImplemented(functionName: String) -> Promise<String> {
        return Promise<String> { fullfil, reject in
            reject(WildAPIServiceProtocolError.NotImplemented(functionName).error)
        }
    }
    static func fetchAnimeEpisodes() -> Promise<String> {
        return self.methodNotImplemented("fetchAnimeEpisodes")
    }
}

enum WildAPIServiceProtocolError: MBError
{
    case NotImplemented(String)
    
    var code: Int {
        switch self {
        case .NotImplemented:
            return 1001
        }
    }
    
    var domain: String {
        return "AnimeAPIServiceProtocolDomain"
    }
    
    var description: String {
        switch self {
        case .NotImplemented:
            return "API function is not implemented yet."
        }
    }
    
    var reason: String {
        switch self {
        case .NotImplemented(let functionName):
            return "\(functionName) is not implemented yet."
        }
    }
}