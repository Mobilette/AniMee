//
//  AnimeListWeekEpisodeCell.swift
//  AniMee
//
//  Created by Issouf M'sa Benaly on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import UIKit

class AnimeListWeekEpisodeCell: UICollectionViewCell
{
    // MARK: - Property
    
    var imageName: String = "" {
        didSet {
            self.animeImageView.image = UIImage(named: imageName)
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet private weak var animeImageView: UIImageView!
}
