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
    
    var imageURL: NSURL? = nil {
        didSet {
            if let url = imageURL {
                self.animeImageView.image = UIImage()
                ImageAPIService.fetchImage(url).then { [unowned self] data -> Void in
                    self.animeImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet private weak var animeImageView: UIImageView!
}
