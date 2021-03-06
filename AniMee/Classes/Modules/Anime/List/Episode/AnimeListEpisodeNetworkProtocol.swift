//
//  AnimeListEpisodeNetworkProtocol.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 12/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit

protocol AnimeListEpisodeNetworkProtocol: class
{
    func fetchAnimeListEpisodes(animeName: String) -> Promise<[AnimeListEpisodeJSONItem]>
}