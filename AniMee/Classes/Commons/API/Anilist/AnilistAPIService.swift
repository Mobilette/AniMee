//
//  AnilistAPIService.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit
import MBLogger
import MobiletteFoundation

class AnilistAPIService: AnimeAPIServiceProtocol
{
    class func fetchAnimeEpisodes() -> Promise<String>
    {
        return AnilistAnimeAPIService.fetchAnimeEpisodes()
    }
}