//
//  AnimeAPIServiceProtocol.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import PromiseKit
import OAuthSwift

protocol AnimeAPIServiceProtocol
{
    func authorize() -> Promise<OAuthSwiftCredential>
    func handleAuthorizingWithOpenURL(url: NSURL)
    func fetchAnimeEpisodes() -> Promise<String>
}