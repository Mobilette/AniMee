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
        let animeListWeekViewItems = self.animeListWeekViewItemsWithAnimeListWeekItems(animeListWeekItems)
    }

    func didFailToFindAnimeEpisodes(error: NSError)
    {
        
    }

    // MARK: - Converting entities
    
    private func animeListWeekViewItemsWithAnimeListWeekItems(
        animeListWeekItems: [AnimeListWeekItem]
    ) -> [AnimeListWeekViewItem]
    {
        var animeListWeekViewItems: [AnimeListWeekViewItem] = []
        for animeListWeekItem in animeListWeekItems {
            let animeListWeekViewItem = AnimeListWeekViewItem()
            animeListWeekViewItem.identifier = animeListWeekItem.identifier
            animeListWeekViewItem.imageURLString = animeListWeekItem.imageURLString
            animeListWeekViewItem.releaseDate = animeListWeekItem.releaseDate
            animeListWeekViewItems.append(animeListWeekViewItem)
        }
        return []
    }
}