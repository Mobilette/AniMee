//
//  AnimeListEpisodeItem.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 16/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListEpisodeItem:
    Equatable,
    CustomStringConvertible
{
    // MARK: - Property
    
    var identifier: String = ""
    var animeName: String = ""
    var episodeNumber: String = ""
    var episodeTitle: String = ""
    var imageURLString: String = ""
    var releaseDate: NSDate = NSDate()
    
    // MARK: - Life cycle
    
    init() {}
    
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

// MARK: - Equatable protocol

func ==(lhs: AnimeListEpisodeItem, rhs: AnimeListEpisodeItem) -> Bool {
    return lhs.identifier == rhs.identifier
}