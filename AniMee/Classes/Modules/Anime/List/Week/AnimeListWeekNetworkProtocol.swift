//
//  AnimeListWeekNetworkProtocol.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit

protocol AnimeListWeekNetworkProtocol: class
{
    func fetchAnimeEpisodes() -> Promise<[AnimeListWeekJSONItem]>
}