//
//  AnimeListDayItem.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 10/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListDayItem:
    Equatable,
    CustomStringConvertible
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
        return "{ AnimeListDayItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListDayItem, rhs: AnimeListDayItem) -> Bool {
    return lhs.identifier == rhs.identifier
}