//
//  AnimeListDayPresenter.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Issouf M'sa Benaly on 9/16/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
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