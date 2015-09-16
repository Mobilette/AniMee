//
//  AnimeListDayViewController.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Issouf M'sa Benaly on 9/16/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import UIKit

class AnimeListDayViewController:
    UIViewController,
    AnimeListDayViewInterface
{
	// MARK: - Property

    var presenter: AnimeListDayModuleInterface? = nil

	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.presenter?.updateView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
