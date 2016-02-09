//
//  AnimeListDayPresenter.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation

class AnimeListDayPresenter:
    AnimeListDayModuleInterface,
    AnimeListDayInteractorOutput
{
	// MARK: - Property
    
    weak var view: AnimeListDayViewInterface? = nil
    var interactor: AnimeListDayInteractorInput? = nil
    var wireframe: AnimeListDayWireframe? = nil

    // MARK: - AnimeListDay module interface

    func updateView()
    {
    	
    }
    
    // MARK: - AnimeListDay interactor output interface

    // MARK: - Converting entities
}