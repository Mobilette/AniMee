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
        let animeListWeekViewItems = self.animeListWeekViewItemsWithCategorisedEpisodes(categorisedEpisodes)
        self.view?.setWeeklyEpisodeList(animeListWeekViewItems)
    }

    func didFailToFindAnimeEpisodes(error: NSError)
    {
        
    }

    // MARK: - Converting entities
    
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
    
    private func animeListWeekViewItemsWithCategorisedEpisodes(
        categorisedEpisodes: [String: [AnimeListWeekItem]]
    ) -> [AnimeListWeekViewItem]
    {
        var animeListWeekViewItems: [AnimeListWeekViewItem] = []
        for categorisedEpisode in categorisedEpisodes {
            let animeListWeekViewItem = AnimeListWeekViewItem()
            animeListWeekViewItem.identifier = NSUUID().UUIDString
            animeListWeekViewItem.title = self.formattedDayStringWithDateString(categorisedEpisode.0)
            let episodeURLImages = self.episodeURLImagesWithAnimeListWeekItems(categorisedEpisode.1)
            animeListWeekViewItem.episodes = episodeURLImages
            animeListWeekViewItems.append(animeListWeekViewItem)
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
    ) -> [String]
    {
        var episodeURLImages: [String] = []
        for animeListWeekItem in animeListWeekItems {
            if let episodeURLImage = animeListWeekItem.imageURLString {
                episodeURLImages.append(episodeURLImage)
            }
        }
        return episodeURLImages
    }

}