//
//  ImageAPIService.swift
//  AbTastyDemo
//
//  Created by Romain ASNAR on 9/3/15.
//  Copyright (c) 2015 ABTasty. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class ImageCache: NSCache
{
    func cacheImageData(imageData: NSData, forURL url: NSURL)
    {
        if let urlString = url.absoluteString {
            self.setObject(imageData, forKey: urlString)
        }
    }
    
    func cachedImageData(forURL url: NSURL) -> NSData?
    {
        if let urlString = url.absoluteString {
            return self.objectForKey(urlString) as? NSData
        }
        return nil
    }
}

class ImageAPIService
{
    // MARK: - Property
    
    static let imageCache: ImageCache = ImageCache()
    
    // MARK: - Request
    
    class func fetchImage(url: NSURL, cacheImage: Bool = true) -> Promise<NSData>
    {
        return Promise<NSData> { fullfil, reject in

            if let cachedImageData = ImageAPIService.imageCache.cachedImageData(forURL: url) {
                fullfil(cachedImageData)
                return
            }

            let imageRouter = ImageRouter.FetchImage(url)
            let request = Alamofire.request(imageRouter)
                .response() { (request, response, data, error) in
                    if let statusCode = response?.statusCode {
                        switch statusCode {
                        case 200...299:
                            if let imageData = data {
                                ImageAPIService.imageCache.cacheImageData(imageData, forURL: url)
                                fullfil(imageData)
                            }
                            else {
                                let missingDatasError = ImageAPIError.MissingData(imageRouter).error
                                reject(missingDatasError)
                            }
                        case 401:
                            let unauthorizedError = ImageAPIError.Unauthorized(imageRouter).error
                            reject(unauthorizedError)
                        default:
                            if let JSONError = error {
                                reject(JSONError)
                            }
                            else {
                                let missingDatasError = ImageAPIError.Unknown(imageRouter).error
                                reject(missingDatasError)
                            }
                        }
                    }
            }
        }
    }
    
    // MARK: - Type
    
    enum ImageAPIError
    {
        case Unknown(RouterProtocol)
        case Unauthorized(RouterProtocol)
        case MissingData(RouterProtocol)
        case Serialization(AnyObject)
        
        var code: Int {
            switch self {
            case .Unknown:
                return 500
            case .Unauthorized:
                return 401
            case .MissingData:
                return 500
            case .Serialization:
                return 500
            }
        }
        
        var domain: String {
            switch self {
            case .Unknown:
                return "NetworkDomain"
            case .Unauthorized:
                return "UserUnauthorizedDomain"
            case .MissingData:
                return "DataManagementDomain"
            case .Serialization:
                return "DataManagementDomain"
            }
        }
        
        var description: String {
            switch self {
            case .Unknown:
                return "Unknown error."
            case .Unauthorized:
                return "Unauthorized."
            case .MissingData:
                return "Missing datas."
            case .Serialization:
                return "Serialization Error."
            }
        }
        
        var reason: String {
            switch self {
            case .Unknown(let router):
                return "Unknown error at \(router.path)\nRequest server: \(router.path) with \(router.method.rawValue) method."
            case .Unauthorized(let router):
                return "Need to be logged before performing \(router.path)\nRequest server: \(router.path) with \(router.method.rawValue) method."
            case .MissingData(let router):
                return "Response string doesn't contain any known datas.\nRequest server: \(router.path) with \(router.method.rawValue) method."
            case .Serialization(let object):
                return "Can not serialize this object: \(object)."
            }
        }
        
        var error: NSError {
            let userInfo = [
                NSLocalizedDescriptionKey: self.description,
                NSLocalizedFailureReasonErrorKey: self.reason
            ]
            return NSError(domain: self.domain, code: self.code, userInfo: userInfo)
        }
    }
}