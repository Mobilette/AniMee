//
//  AnimeListEpisodeInteractorIO.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 12/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

protocol AnimeListEpisodeInteractorInput: class
{
    func findAnimeListEpisodes()
}

protocol AnimeListEpisodeInteractorOutput: class
{
    func didFindAnimeListEpisodes(animeEpisodeItems: [AnimeListEpisodeItem])
    func didFailToFindAnimeListEpisodes(error: ErrorType)
}