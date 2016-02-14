//
//  AnimeListEpisodePresenter.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 12/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListEpisodePresenter:
    AnimeListEpisodeModuleInterface,
    AnimeListEpisodeInteractorOutput
{
	// MARK: - Property
    
    weak var view: AnimeListEpisodeViewInterface? = nil
    var interactor: AnimeListEpisodeInteractorInput? = nil
    var wireframe: AnimeListEpisodeWireframe? = nil

    // MARK: - AnimeListEpisode module interface

    func updateView()
    {
    	
    }
    
    // MARK: - AnimeListEpisode interactor output interface

    // MARK: - Converting entities
}