//
//  AnimeListWeekPresenter.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

class AnimeListWeekPresenter:
    AnimeListWeekModuleInterface,
    AnimeListWeekInteractorOutput
{
	// MARK: - Property
    
    weak var view: AnimeListWeekViewInterface? = nil
    var interactor: AnimeListWeekInteractorInput? = nil
    var wireframe: AnimeListWeekWireframe? = nil

    // MARK: - AnimeListWeek module interface

    func updateView()
    {
    	<# ... #>
    }
    
    // MARK: - AnimeListWeek interactor output interface

    // MARK: - Converting entities
}