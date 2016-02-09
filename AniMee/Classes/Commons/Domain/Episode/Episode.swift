//
//  Episode.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class Episode:
    Equatable,
    CustomStringConvertible
{
    // MARK: - Property

    var identifier: String? = nil
    var title: String? = nil
    var imageURLString: String? = nil
    var releaseDate: NSDate? = nil

    // MARK: - Life cycle

    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ Episode" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "title: \(self.title)" + "\n"
            + "imageURLString: \(self.imageURLString)" + "\n"
            + "releaseDate: \(self.releaseDate)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: Episode, rhs: Episode) -> Bool {
    return lhs.identifier == rhs.identifier
}