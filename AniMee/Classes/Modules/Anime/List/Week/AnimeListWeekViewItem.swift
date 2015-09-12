//
//  AnimeListWeekViewItem.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/13/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListWeekViewItem:
    Equatable,
    Printable
{
    // MARK: - Property

    var identifier: String? = nil
    var imageURLString: String? = nil
    var releaseDate: NSDate? = nil

    // MARK: - Life cycle

    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekViewItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListWeekViewItem, rhs: AnimeListWeekViewItem) -> Bool {
    return lhs.identifier == rhs.identifier
}