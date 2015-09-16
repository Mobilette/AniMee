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
    
    var title: String = "" {
        didSet {
            self.animeTitle.text = title
        }
    }
    
    var imageURL: NSURL? = nil {
        didSet {
            if self.animeImageView.layer.cornerRadius <= 0 {
                self.animeImageView.layer.cornerRadius = (CGRectGetWidth(self.bounds) - 10) / 2
            }
            if let url = imageURL {
                self.animeImageView.image = UIImage()
                ImageAPIService.fetchImage(url).then { [unowned self] data -> Void in
                    self.animeImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet private weak var animeTitle: UILabel!
    @IBOutlet private weak var animeImageView: UIImageView!
}
