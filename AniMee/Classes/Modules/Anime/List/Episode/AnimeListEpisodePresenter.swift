//
//  AnimeListEpisodePresenter.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 12/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListEpisodePresenter:
    AnimeListEpisodeModuleInterface,
    AnimeListEpisodeInteractorOutput
{
	// MARK: - Property
    
    weak var view: AnimeListEpisodeViewInterface? = nil
    var interactor: AnimeListEpisodeInteractorInput? = nil
    var wireframe: AnimeListEpisodeWireframe? = nil

    // MARK: - AnimeListEpisode module interface

    func updateView()
    {
    	self.interactor?.findAnimeListEpisodes()
    }
    
    // MARK: - AnimeListEpisode interactor output interface

    func didFindAnimeListEpisodes(animeEpisodeItems: [AnimeListEpisodeItem])
    {
        let animeEpisodesViewItems = self.animeListEpisodeViewItem(animeEpisodeItems)
        self.view?.setAnimeEpisodesViewList(animeEpisodesViewItems)
    }
    
    func didFailToFindAnimeListEpisodes(error: ErrorType)
    {
        
    }
    
    // MARK: - Converting entities
    
    private func animeListEpisodeViewItem(animeEpisodeItems: [AnimeListEpisodeItem]) -> [AnimeListEpisodeViewItem]
    {
        var episodeViewItems: [AnimeListEpisodeViewItem] = []
        for item in animeEpisodeItems {
            let episodeItem = AnimeListEpisodeViewItem(animeListEpisodeItem: item)
            episodeViewItems.append(episodeItem)
        }
        return episodeViewItems
    }
}