//
//  AnimeListWeekItem.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListWeekItem:
    Equatable,
    Printable
{
    // MARK: - Property

    var identifier: String? = nil
    var title: String = ""
    var imageURLString: String? = nil
    var releaseDate: NSDate = NSDate()

    // MARK: - Life cycle

    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListWeekItem, rhs: AnimeListWeekItem) -> Bool {
    return lhs.identifier == rhs.identifier
}