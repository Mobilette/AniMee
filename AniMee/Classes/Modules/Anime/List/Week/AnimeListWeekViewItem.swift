//
//  AnimeListWeekViewItem.swift
//  AniMee
//
//  Created by Issouf M'sa Benaly on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListWeekViewItem:
    Equatable,
    Printable
{
    // MARK: - Property

    var identifier: String? = nil
    var title: String = ""
    var episodes: [String] = []

    // MARK: - Life cycle

    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekViewItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "episodes: \(self.episodes)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListWeekViewItem, rhs: AnimeListWeekViewItem) -> Bool {
    return lhs.identifier == rhs.identifier
}