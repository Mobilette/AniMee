//
//  AnimeListDayInteractorIO.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

protocol AnimeListDayInteractorInput: class
{
    func findListOfAnimeEpisodeForASepecificDay()
}

protocol AnimeListDayInteractorOutput: class
{
    // Review for the object
    func didFindListOfAnimeEpisodeForASepecificDay(episodesOfDay: [AnimeListDayItem])
    func didFailToFindListOfAnimeEpisodeForASepecificDay(error: ErrorType)
}