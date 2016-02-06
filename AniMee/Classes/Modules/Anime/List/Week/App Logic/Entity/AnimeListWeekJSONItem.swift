//
//  AnimeListWeekJSONItem.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import ObjectMapper

class AnimeListWeekJSONItem:
    Equatable,
    CustomStringConvertible,
    Mappable
{
    // MARK: - Property

    var identifier: Int? = nil
    var title: String? = nil
    var imageURLString: String? = nil
    var releaseDate: NSDate? = nil

    // MARK: - Life cycle
    
    init() {}
    
//    // MARK: - Mappable protocol
    
    required init?(_ map: Map) {
        
    }
    
    class func newInstance(map: Map) -> Mappable?
    {
        return AnimeListWeekJSONItem()
    }
    
    func mapping(map: Map)
    {
        identifier      <- map["id"]
        title           <- map["title_english"]
        imageURLString  <- map["image_url_lge"]
        releaseDate     <- (map["airing.time"], APIDateISO8601Transform())
    }
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekJSONItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListWeekJSONItem, rhs: AnimeListWeekJSONItem) -> Bool {
    return lhs.identifier == rhs.identifier
}