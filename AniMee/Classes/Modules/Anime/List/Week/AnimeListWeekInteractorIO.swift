//
//  AnimeListWeekInteractorIO.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

protocol AnimeListWeekInteractorInput: class
{
    func findAnimeEpisodes()
}

protocol AnimeListWeekInteractorOutput: class
{
    func didFindAnimeEpisodes(animeListWeekItems: [AnimeListWeekItem])
    func didFailToFindAnimeEpisodes(error: NSError)
}