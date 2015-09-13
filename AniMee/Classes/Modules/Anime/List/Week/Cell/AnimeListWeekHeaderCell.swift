//
//  AnimeListWeekHeaderCell.swift
//  AniMee
//
//  Created by Issouf M'sa Benaly on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import UIKit

class AnimeListWeekHeaderCell: UICollectionViewCell
{    
    // MARK: - Property
    
    var title: String = "" {
        didSet {
            self.animeLabel.text = title
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet private weak var animeLabel: UILabel!
}