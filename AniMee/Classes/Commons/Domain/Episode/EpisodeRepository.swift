//
//  EpisodeRepository.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class EpisodeRepository:
    Equatable,
    CustomStringConvertible
{
    // MARK: - Property

    var episodes: [Episode] = []

    // MARK: - Life cycle

    init() {}
    
    // MARK: - Repository
    
    func addEpisodes(episodes: [Episode])
    {
        self.episodes.appendContentsOf(episodes)
    }
    
    func addEpisode(episode: Episode)
    {
        self.episodes.append(episode)
    }
    
    func removeAllEpisodes()
    {
        self.episodes.removeAll(keepCapacity: false)
    }
    
    func removeEpisode(episode: Episode)
    {
        if let index = self.episodes.indexOf(episode) {
            self.episodes.removeAtIndex(index)
        }
    }
    
    func findAllEpisodes() -> [Episode]
    {
        return self.episodes
    }
    
    func findEpisodeWithIdentifier(identifier: String?) -> [Episode]
    {
        return self.episodes.filter({
            return $0.identifier == identifier
        })
    }
    
    // MARK: - Printable protocol
    
    var description: String {
        return "{ EpisodeRepository" + "\n"
            + "episodes: \(self.episodes)" + "\n"
            + "}" + "\n"
    }
}

// MARK: - Equatable protocol

func ==(lhs: EpisodeRepository, rhs: EpisodeRepository) -> Bool {
    return lhs.episodes == rhs.episodes
}