//
//  AnimeListDayCell.swift
//  AniMee
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import UIKit

class AnimeListDayCell: UICollectionViewCell {
    var name: String = "" {
        didSet {
            self.animeTitle.text = name
        }
    }
    
    var season: String = "" {
        didSet {
            self.animeSeason.text = season
        }
    }
    
    var number: String = "" {
        didSet {
            self.episodeNumber.text = number
        }
    }

    var title: String = "" {
        didSet {
            self.episodeTitle.text = title
        }
    }

    var hour: String = "" {
        didSet {
            self.releaseHour.text = hour
        }
    }
    
    var imageURL: NSURL? = nil {
        didSet {
            self.animeImageView.image = UIImage()
            if let url = imageURL {
                ImageAPIService.fetchImage(url).then { [unowned self] data -> Void in
                    self.animeImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet private weak var animeTitle: UILabel!
    @IBOutlet private weak var animeSeason: UILabel!
    @IBOutlet private weak var episodeNumber: UILabel!
    @IBOutlet private weak var episodeTitle: UILabel!
    @IBOutlet private weak var releaseHour: UILabel!
    @IBOutlet private weak var animeImageView: UIImageView!

}
