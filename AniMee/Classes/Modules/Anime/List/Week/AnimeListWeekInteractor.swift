//
//  AnimeListWeekInteractor.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

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
                .then { [unowned self] animeEpisodeJSONItems -> Void in
                    let filteredEpisodeJSONItems = self.removeEpisodesWithNoReleaseDate(animeEpisodeJSONItems)
                    let episodes = self.episodesWithAnimeEpisodeJSONItems(filteredEpisodeJSONItems)
                    self.episodeRepository.removeAllEpisodes()
                    self.episodeRepository.addEpisodes(episodes)
                    let animeListWeekListItems = self.animeListWeekListItemsWithEpisodes(self.episodeRepository.episodes)
                    self.output?.didFindAnimeEpisodes(animeListWeekListItems)
            }
                .catch { [unowned self] error -> Void in
                    self.output?.didFailToFindAnimeEpisodes(error)
            }
        }
    }
    
    // MARK: - Filtering
    
    func removeEpisodesWithNoReleaseDate(
        allEpisodeJSONItems: [AnimeListWeekJSONItem]
        ) -> [AnimeListWeekJSONItem]
    {
        var filteredEpisodeJSONItems :[AnimeListWeekJSONItem] = []
        return filteredEpisodeJSONItems
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
            let animeListWeekItem = AnimeListWeekItem()
            animeListWeekItem.identifier = episode.identifier
            animeListWeekItem.title = episode.title ?? ""
            animeListWeekItem.imageURLString = episode.imageURLString
            animeListWeekItem.releaseDate = episode.releaseDate
            animeListWeekItems.append(animeListWeekItem)
        }
        return animeListWeekItems
    }
}
