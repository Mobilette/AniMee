//
//  AnimeListEpisodeViewItem.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 16/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListEpisodeViewItem:
    Equatable,
    CustomStringConvertible
{
    // MARK: - Property
    
    var identifier: String? = nil
    var animeName: String = ""
    var title: String = ""
    var imageURL: NSURL? = nil
    var episodeNumber: String = ""
    
    // MARK: - Life cycle
    
    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekEpisodeViewItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "animeName: \(self.animeName)" + "\n"
            + "episodeNumber: \(self.episodeNumber)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURL: \(self.imageURL)" + "\n"
            + "}" + "\n"
    }
}

extension AnimeListEpisodeViewItem
{
    convenience init(animeListEpisodeItem: AnimeListEpisodeItem)
    {
        self.init()
        self.identifier = animeListEpisodeItem.identifier
        self.animeName = animeListEpisodeItem.animeName
        self.title = animeListEpisodeItem.episodeTitle
        self.imageURL = NSURL(string: animeListEpisodeItem.imageURLString)
        self.episodeNumber = animeListEpisodeItem.episodeNumber
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListEpisodeViewItem, rhs: AnimeListEpisodeViewItem) -> Bool {
    return lhs.identifier == rhs.identifier
}