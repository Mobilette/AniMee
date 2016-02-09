//
//  AnimeAPIServiceProtocol.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit
import MobiletteFoundation

protocol AnimeAPIServiceProtocol
{
    func authorize() -> Promise<MBOAuthCredential>
    func fetchAnimeEpisodes() -> Promise<String>
}