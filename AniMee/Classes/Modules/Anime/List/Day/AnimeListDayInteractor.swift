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

    // MARK: - AnimeListDay interactor input interface

    func findListOfAnimeEpisodeForASepecificDay(date: NSDate)
    {
        self.networkController?.fetchAnimeEpisodesOfSpecificDay(date)
        .then { [unowned self] JSONItem -> Void in
        let item = self.animeEpisodesItem(JSONItem)
        MBLog.app(MBLog.Level.High, object: "Did find anime episode for a specific day: \(item).")
        self.output?.didFindListOfAnimeEpisodeForASepecificDay(item)
        }
        .error { [unowned self] error -> Void in
            MBLog.app(MBLog.Level.High, object: "Did fail to <# failure action #>.")
            self.output?.didFailToFindListOfAnimeEpisodeForASepecificDay(error)
        }
    }
    
    // MARK: - Converting raw datas
    
    private func animeEpisodesItem(animeListDayJSONItem: [AnimeListDayJSONItem]) -> [AnimeListDayItem]
    {
        return [AnimeListDayItem()]
    }
}
