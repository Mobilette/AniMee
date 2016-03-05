//
//  AnimeListEpisodeJSONItem.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 16/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import ObjectMapper

class AnimeListEpisodeJSONItem:
    Equatable,
    CustomStringConvertible,
    Mappable
{
    // MARK: - Property

    var identifier: String?
    var animeName: String?
    var episodeNumber: String?
    var episodeTitle: String?
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
        // To do: Mapping not finish yet
        identifier <- map["id"]
    }
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListEpisodeJSONItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "episodeNumber: \(self.episodeNumber)" + "\n"
            + "episodeTitle: \(self.episodeTitle)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

extension AnimeListEpisodeItem
{
    convenience init(animeListEpisodeJSONItem: AnimeListEpisodeJSONItem)
    {
        self.init()
        if let id = animeListEpisodeJSONItem.identifier {
            self.identifier = id
        }
        if let name = animeListEpisodeJSONItem.animeName {
            self.animeName = name
        }
        if let number = animeListEpisodeJSONItem.episodeNumber {
            self.episodeNumber = number
        }
        if let title = animeListEpisodeJSONItem.episodeTitle {
            self.episodeTitle = title
        }
        if let imageUrl = animeListEpisodeJSONItem.imageURLString {
            self.imageURLString = imageUrl
        }
        if let date = animeListEpisodeJSONItem.releaseDate {
            self.releaseDate = date
        }
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListEpisodeJSONItem, rhs: AnimeListEpisodeJSONItem) -> Bool {
    return lhs.identifier == rhs.identifier
}