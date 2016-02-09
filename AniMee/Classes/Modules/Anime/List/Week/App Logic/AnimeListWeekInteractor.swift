//
//  AnimeListWeekInteractor.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import MBLogger

class AnimeListWeekInteractor:
    AnimeListWeekInteractorInput
{
	// MARK: - Property
    
    weak var output: AnimeListWeekInteractorOutput? = nil
    var networkController: AnimeListWeekNetworkProtocol? = nil
    
    private var episodeRepository: EpisodeRepository = EpisodeRepository()

    // MARK: - AnimeListWeek interactor input interface
    
    func findAnimeEpisodes()
    {
        if self.episodeRepository.episodes.count > 0 {
            let animeListWeekListItems = self.animeListWeekListItemsWithEpisodes(self.episodeRepository.episodes)
            self.output?.didFindAnimeEpisodes(animeListWeekListItems)
        }
        else {
            self.networkController?.fetchAnimeEpisodes()
                .then {  animeEpisodeJSONItems -> Void in
                    let filteredEpisodeJSONItems = self.filterEpisodeByReleaseDate(animeEpisodeJSONItems)
                    let episodes = self.episodesWithAnimeEpisodeJSONItems(filteredEpisodeJSONItems)
                    self.episodeRepository.removeAllEpisodes()
                    self.episodeRepository.addEpisodes(episodes)
                    let animeListWeekListItems = self.animeListWeekListItemsWithEpisodes(self.episodeRepository.episodes)
                    MBLog.data(MBLog.Level.High, object: "Did fetch anime episodes [\(animeListWeekListItems.count)]: \(animeListWeekListItems)")
                    self.output?.didFindAnimeEpisodes(animeListWeekListItems)
            }
                .error {  error -> Void in
                    self.output?.didFailToFindAnimeEpisodes(error)
            }
        }
    }
    
    // MARK: - Filtering
    
    func filterEpisodeByReleaseDate(
        allEpisodeJSONItems: [AnimeListWeekJSONItem]
        ) -> [AnimeListWeekJSONItem]
    {
        let today = self.dateWithoutTime(NSDate()) ?? NSDate()
        var filteredEpisodeJSONItems :[AnimeListWeekJSONItem] = []
        for episodeJSONItem in allEpisodeJSONItems {
            if let releaseDate = episodeJSONItem.releaseDate {
                let releaseDateWithoutTime = self.dateWithoutTime(releaseDate) ?? releaseDate
                let comparaisonToToday = releaseDateWithoutTime.compare(today)
                if comparaisonToToday == NSComparisonResult.OrderedDescending
                    || comparaisonToToday == NSComparisonResult.OrderedSame
                {
                    filteredEpisodeJSONItems.append(episodeJSONItem)
                }
            }
        }
        return filteredEpisodeJSONItems
    }
    
    // MARK: - Date
    
    private func dateWithoutTime(date: NSDate) -> NSDate?
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDateString = formatter.stringFromDate(date)
        return formatter.dateFromString(formattedDateString)
    }

    // MARK: - Converting raw datas
    
    private func episodesWithAnimeEpisodeJSONItems(
        animeListWeekJSONItems: [AnimeListWeekJSONItem]
    ) -> [Episode]
    {
        var episodes: [Episode] = []
        for animeListWeekJSONItem in animeListWeekJSONItems {
            let episode = Episode()
            episode.identifier = "\(animeListWeekJSONItem.identifier)"
            episode.title = animeListWeekJSONItem.title
            episode.imageURLString = animeListWeekJSONItem.imageURLString
            episode.releaseDate = animeListWeekJSONItem.releaseDate
            episodes.append(episode)
        }
        return episodes
    }
    
    private func animeListWeekListItemsWithEpisodes(
        episodes: [Episode]
    ) -> [AnimeListWeekItem]
    {
        var animeListWeekItems: [AnimeListWeekItem] = []
        for episode in episodes {
            if let releaseDate = episode.releaseDate {
                let animeListWeekItem = AnimeListWeekItem()
                animeListWeekItem.identifier = episode.identifier
                animeListWeekItem.title = episode.title ?? ""
                animeListWeekItem.imageURLString = episode.imageURLString
                animeListWeekItem.releaseDate = releaseDate
                animeListWeekItems.append(animeListWeekItem)
            }
        }
        return animeListWeekItems
    }
}
