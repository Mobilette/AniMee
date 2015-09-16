//
//  AnimeListWeekEpisodeViewItem.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/16/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListWeekEpisodeViewItem:
    Equatable,
    Printable
{
    // MARK: - Property

    var identifier: String? = nil
    var title: String = ""
    var imageURL: NSURL? = nil

    // MARK: - Life cycle

    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekEpisodeViewItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURL: \(self.imageURL)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListWeekEpisodeViewItem, rhs: AnimeListWeekEpisodeViewItem) -> Bool {
    return lhs.identifier == rhs.identifier
}