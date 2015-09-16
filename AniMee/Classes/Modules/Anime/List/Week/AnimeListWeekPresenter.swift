//
//  AnimeListWeekPresenter.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListWeekPresenter:
    AnimeListWeekModuleInterface,
    AnimeListWeekInteractorOutput
{
	// MARK: - Property
    
    weak var view: AnimeListWeekViewInterface? = nil
    var interactor: AnimeListWeekInteractorInput? = nil
    var wireframe: AnimeListWeekWireframe? = nil

    // MARK: - AnimeListWeek module interface

    func updateView()
    {
    	self.interactor?.findAnimeEpisodes()
    }
    
    // MARK: - AnimeListWeek interactor output interface
    
    func didFindAnimeEpisodes(animeListWeekItems: [AnimeListWeekItem])
    {
        let categorisedEpisodes = self.categorisedEpisodes(animeListWeekItems)
        let sortedEpisodes = self.sortEpisodesByDate(categorisedEpisodes)
        let animeListWeekViewItems = self.animeListWeekViewItemsWithCategorisedEpisodes(sortedEpisodes)
        self.view?.setWeeklyEpisodeList(animeListWeekViewItems)
    }

    func didFailToFindAnimeEpisodes(error: NSError)
    {
        
    }
    
    // MARK: - Sorting
    
    private func categorisedEpisodes(
        episodes: [AnimeListWeekItem]
        ) -> [String: [AnimeListWeekItem]]
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let categorisedEpisodes = categorise(episodes) {
            formatter.stringFromDate($0.releaseDate)
        }
        return categorisedEpisodes
    }
    
    private func sortEpisodesByDate(
        categorisedEpisodes: [String: [AnimeListWeekItem]]
    ) -> [[String: [AnimeListWeekItem]]]
    {
        var dates: [String] = categorisedEpisodes.keys.array
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dates.sort({
            let date1 = formatter.dateFromString($0) ?? NSDate()
            let date2 = formatter.dateFromString($1) ?? NSDate()
            return date1.compare(date2) == NSComparisonResult.OrderedAscending
        })
        var episodes: [[String: [AnimeListWeekItem]]] = []
        for date in dates {
            if let categorisedEpisode = categorisedEpisodes[date] {
                episodes.append([date: categorisedEpisode])
            }
        }
        return episodes
    }

    // MARK: - Converting entities
    
    private func animeListWeekViewItemsWithCategorisedEpisodes(
        sortedEpisodes: [[String: [AnimeListWeekItem]]]
    ) -> [AnimeListWeekViewItem]
    {
        var animeListWeekViewItems: [AnimeListWeekViewItem] = []
        for sortedEpisode in sortedEpisodes {
            for episode in sortedEpisode {
                let animeListWeekViewItem = AnimeListWeekViewItem()
                animeListWeekViewItem.identifier = NSUUID().UUIDString
                animeListWeekViewItem.title = self.formattedDayStringWithDateString(episode.0)
                let episodeURLImages = self.episodeURLImagesWithAnimeListWeekItems(episode.1)
                animeListWeekViewItem.episodes = episodeURLImages
                animeListWeekViewItems.append(animeListWeekViewItem)
            }
        }
        return animeListWeekViewItems
    }
    
    private func formattedDayStringWithDateString(
        dateString: String
    ) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.dateFromString(dateString) {
            formatter.dateFormat = "EEEE, MMMM d"
            return formatter.stringFromDate(date)
        }
        return ""
    }
    
    private func episodeURLImagesWithAnimeListWeekItems(
        animeListWeekItems: [AnimeListWeekItem]
    ) -> [AnimeListWeekEpisodeViewItem]
    {
        var animeListWeekEpisodeViewItems: [AnimeListWeekEpisodeViewItem] = []
        for animeListWeekItem in animeListWeekItems {
            if let episodeURLImage = animeListWeekItem.imageURLString {
                let animeListWeekEpisodeViewItem = AnimeListWeekEpisodeViewItem()
                animeListWeekEpisodeViewItem.title = animeListWeekItem.title
                animeListWeekEpisodeViewItem.imageURL = NSURL(string: episodeURLImage)
                animeListWeekEpisodeViewItems.append(animeListWeekEpisodeViewItem)
            }
        }
        return animeListWeekEpisodeViewItems
    }

}