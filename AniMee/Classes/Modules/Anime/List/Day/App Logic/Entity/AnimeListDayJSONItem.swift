//
//  AnimeListDayJSONItem.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 10/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import ObjectMapper

class AnimeListDayJSONItem:
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
    
    // MARK: - Mappable protocol

    required init?(_ map: Map)
    {
        mapping(map)
    }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        title <- map["title"]
        imageURLString <- map["imageURLString"]
        releaseDate <- (map["releaseDate"], APIDateISO8601Transform())
    }
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListDayJSONItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

extension AnimeListDayItem
{
    convenience init(animeListDayJSONItem: AnimeListDayJSONItem)
    {
        self.init()
        self.identifier = "\(animeListDayJSONItem.identifier)"
        if let title = animeListDayJSONItem.title {
            self.title = title
        }
        if let imageUrl = animeListDayJSONItem.imageURLString {
            self.imageURLString = imageUrl
        }
        if let date = animeListDayJSONItem.releaseDate {
            self.releaseDate = date
        }
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListDayJSONItem, rhs: AnimeListDayJSONItem) -> Bool {
    return lhs.identifier == rhs.identifier
}