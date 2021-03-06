//
//  AnimeListDayNetworkProtocol.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit

protocol AnimeListDayNetworkProtocol: class
{
    func fetchAnimeEpisodesOfSpecificDay(date: NSDate) -> Promise<[AnimeListDayJSONItem]>
}