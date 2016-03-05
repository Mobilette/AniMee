//
//  AnimeListEpisodeInteractor.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 12/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import MBLogger

class AnimeListEpisodeInteractor:
    AnimeListEpisodeInteractorInput
{
	// MARK: - Property
    
    weak var output: AnimeListEpisodeInteractorOutput? = nil
    var networkController: AnimeListEpisodeNetworkProtocol? = nil
    private var animeName: String = ""
    
    // MARK: - Life cycle
    
    init(name: String)
    {
        self.animeName = name
    }

    // MARK: - AnimeListEpisode interactor input interface

    func findAnimeListEpisodes()
    {
        self.networkController?.fetchAnimeListEpisodes(self.animeName)
        .then { [unowned self] JSONItem -> Void in
        let item = self.episodesItem(JSONItem)
        MBLog.app(MBLog.Level.High, object: "Did find anime's epiodes: \(item).")
        self.output?.didFindAnimeListEpisodes(item)
        }
        .error { [unowned self] error -> Void in
            MBLog.app(MBLog.Level.High, object: "Did fail to find anime's epiodes.")
            self.output?.didFailToFindAnimeListEpisodes(error)
        }
    }
    
    // MARK: - Converting raw datas
    
    private func episodesItem(animeListEpisodeJSONItem: [AnimeListEpisodeJSONItem]) -> [AnimeListEpisodeItem]
    {
        var episodeItems: [AnimeListEpisodeItem] = []
        for item in animeListEpisodeJSONItem {
            let episodeItem = AnimeListEpisodeItem(animeListEpisodeJSONItem: item)
            episodeItems.append(episodeItem)
        }
        return episodeItems
    }
}
