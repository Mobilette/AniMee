//
//  AnimeListDayPresenter.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListDayPresenter:
    AnimeListDayModuleInterface,
    AnimeListDayInteractorOutput
{
	// MARK: - Property
    
    weak var view: AnimeListDayViewInterface? = nil
    var interactor: AnimeListDayInteractorInput? = nil
    var wireframe: AnimeListDayWireframe? = nil

    // MARK: - AnimeListDay module interface

    func updateView()
    {
    	// self.interactor?.findListOfAnimeEpisodeForASepecificDay()
    }
    
    // MARK: - AnimeListDay interactor output interface

    func didFindListOfAnimeEpisodeForASepecificDay(episodesOfDay: [AnimeListDayItem])
    {
        let releaseOfTheDay = self.animeEpisodesViewItem(episodesOfDay)
        self.view?.setAnimeListDayEpisode(releaseOfTheDay)
    }
    
    func didFailToFindListOfAnimeEpisodeForASepecificDay(error: ErrorType)
    {
        
    }
    
    func showAnimeListEpisodeInterface(animeName: String)
    {
        self.wireframe?.prepareAnimeListEpisodeInterface(animeName)
    }
    
    // MARK: - Converting entities
    
    private func animeEpisodesViewItem(animeListDayItem: [AnimeListDayItem]) -> [AnimeListDayEpisodeViewItem]
    {
        var dayEpisodeItems: [AnimeListDayEpisodeViewItem] = []
        for item in animeListDayItem {
            let dayEpisodeItem = AnimeListDayEpisodeViewItem(animeListDayItem: item)
            dayEpisodeItems.append(dayEpisodeItem)
        }
        return dayEpisodeItems
    }
}