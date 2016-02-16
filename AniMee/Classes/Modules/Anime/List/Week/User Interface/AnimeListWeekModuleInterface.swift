//
//  AnimeListWeekModuleInterface.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

protocol AnimeListWeekModuleInterface: class
{
	func updateView()
    func showAnimeListDayInterface(date: NSDate)
}