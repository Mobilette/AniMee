//
//  AnimeListDayEpisodeViewItem.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 16/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListDayEpisodeViewItem:
    Equatable,
    CustomStringConvertible
{
    // MARK: - Property
    
    var identifier: String? = nil
    var animeName: String = ""
    var imageURL: NSURL? = nil
    var hour: String = ""
    
    // MARK: - Life cycle
    
    init() {}
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ AnimeListWeekEpisodeViewItem" + "\n"
            + "identifier: \(self.identifier)" + "\n"
            + "animeName: \(self.animeName)" + "\n"
            + "imageURL: \(self.imageURL)" + "\n"
            + "}" + "\n"
    }
}

extension AnimeListDayEpisodeViewItem
{
    convenience init(animeListDayItem: AnimeListDayItem)
    {
        self.init()
        self.identifier = animeListDayItem.identifier
        self.animeName = animeListDayItem.title
        if let imageUrl = animeListDayItem.imageURLString {
            self.imageURL = NSURL(string: imageUrl)
        }
        self.hour = self.formatHour(animeListDayItem.releaseDate)
    }
    
    private func formatHour(date: NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(date)
    }
}

// MARK: - Equatable protocol

func ==(lhs: AnimeListDayEpisodeViewItem, rhs: AnimeListDayEpisodeViewItem) -> Bool {
    return lhs.identifier == rhs.identifier
}