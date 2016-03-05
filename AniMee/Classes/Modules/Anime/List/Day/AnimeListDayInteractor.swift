//
//  AnimeListDayInteractor.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import MBLogger

class AnimeListDayInteractor:
    AnimeListDayInteractorInput
{
	// MARK: - Property
    
    weak var output: AnimeListDayInteractorOutput? = nil
    var networkController: AnimeListDayNetworkProtocol? = nil
    private var episodeDate: NSDate = NSDate()
    
    init(date: NSDate)
    {
        self.episodeDate = date
    }
    
    // MARK: - AnimeListDay interactor input interface

    func findListOfAnimeEpisodeForASepecificDay()
    {
        self.networkController?.fetchAnimeEpisodesOfSpecificDay(self.episodeDate)
        .then { [unowned self] JSONItem -> Void in
        let item = self.animeEpisodesItem(JSONItem)
        MBLog.app(MBLog.Level.High, object: "Did find anime episode for a specific day: \(item).")
        self.output?.didFindListOfAnimeEpisodeForASepecificDay(item)
        }
        .error { [unowned self] error -> Void in
            MBLog.app(MBLog.Level.High, object: "Did fail to find anime episode for a specific day.")
            self.output?.didFailToFindListOfAnimeEpisodeForASepecificDay(error)
        }
    }
    
    // MARK: - Converting raw datas
    
    private func animeEpisodesItem(animeListDayJSONItem: [AnimeListDayJSONItem]) -> [AnimeListDayItem]
    {
        var dayEpisodeItems: [AnimeListDayItem] = []
        for item in animeListDayJSONItem {
            let dayEpisodeItem = AnimeListDayItem(animeListDayJSONItem: item)
            dayEpisodeItems.append(dayEpisodeItem)
        }
        return dayEpisodeItems
    }
}
