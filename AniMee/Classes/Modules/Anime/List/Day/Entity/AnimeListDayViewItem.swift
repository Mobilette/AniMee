//
//  AnimeListDayViewItem.swift
//  AniMee
//
//  Created by Issouf M'sa Benaly on 9/16/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListDayViewItem:
    Equatable,
    Printable
{
    // MARK: - Property
    
    var identifier: String? = nil
    var titleAnime: String = ""
    var titleEpisode: String = ""
    var imageURL: NSURL? = nil
    var releaseDate: NSDate = NSDate()
    var season: String? = ""
    var episodeNumber: String? = ""
    
    // MARK: - Life cycle
    
    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "titleAnime: \(self.titleAnime)" + "\n"
            + "titleEpisode: \(self.titleEpisode)" + "\n"
            + "imageURL: \(self.imageURL)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "season: \(self.season)" + "\n"
            + "episodeNumber: \(self.episodeNumber)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListDayViewItem, rhs: AnimeListDayViewItem) -> Bool {
    return lhs.identifier == rhs.identifier
}

