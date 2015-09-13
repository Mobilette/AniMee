//
//  AnimeListWeekViewController.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import UIKit

class AnimeListWeekViewController:
    UICollectionViewController,
    UICollectionViewDelegateFlowLayout,
    AnimeListWeekViewInterface
{
	// MARK: - Property
    
    private var dailyEpisodes: [AnimeListWeekViewItem] = []
    
    var presenter: AnimeListWeekModuleInterface? = nil

	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dailyEpisodes = self.defaultDailyEpisode()
        self.presenter?.updateView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func defaultDailyEpisode() -> [AnimeListWeekViewItem]
    {
        let monday = AnimeListWeekViewItem()
        monday.title = "Lundi - 04/06"
        monday.episodes = ["one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg", "one_piece.jpeg"]
        let tuesday = AnimeListWeekViewItem()
        tuesday.title = "Mardi - 05/06"
        tuesday.episodes = ["one_piece.jpeg"]
        return [monday, tuesday]
    }
    
    // MARK: - Collection view data source
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView
        ) -> Int
    {
        return self.dailyEpisodes.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let dailyEpisode = self.dailyEpisodes[section]
        return dailyEpisode.episodes.count + 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let animeListWeekHeaderCellIdentifier = "AnimeListWeekHeaderCell"
        let animeListWeekEpisodeCellIdentifier = "AnimeListWeekEpisodeCell"
        let cellIdentifier: String = (self.isHeaderCell(forIndexPath: indexPath) == true) ? animeListWeekHeaderCellIdentifier : animeListWeekEpisodeCellIdentifier
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell

        let dailyEpisode = self.dailyEpisode(forIndexPath: indexPath)
        switch cellIdentifier {
        case animeListWeekHeaderCellIdentifier:
            let animeListWeekHeaderCell = cell as! AnimeListWeekHeaderCell
            animeListWeekHeaderCell.title = dailyEpisode ?? ""
        case animeListWeekEpisodeCellIdentifier:
            let animeListWeekEpisodeCell = cell as! AnimeListWeekEpisodeCell
            animeListWeekEpisodeCell.imageName = dailyEpisode ?? ""
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - Collection view delegate flow layout
    
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath
        ) -> CGSize
    {
        if self.isHeaderCell(forIndexPath: indexPath) {
            let headerSize = CGSizeMake(CGRectGetWidth( collectionView.bounds), 30)
            return headerSize
        }
        else {
            return CGSizeMake(40, 40)
        }
    }
    
    private func isHeaderCell(forIndexPath indexPath: NSIndexPath) -> Bool
    {
        var numberOfItems = 0
        let dailyEpisode = self.dailyEpisodes[indexPath.section]
        numberOfItems += 1
        if numberOfItems == indexPath.row + 1 {
            return true
        }
        numberOfItems += dailyEpisode.episodes.count
        if numberOfItems >= indexPath.row + 1 {
            return false
        }
        return false
    }
    
    private func dailyEpisode(forIndexPath indexPath: NSIndexPath) -> String?
    {
        var numberOfItems = 0
        let dailyEpisode = self.dailyEpisodes[indexPath.section]
        numberOfItems += 1
        if numberOfItems == indexPath.row + 1 {
            return dailyEpisode.title
        }
        let numberOfDailyEpisode = dailyEpisode.episodes.count
        numberOfItems += numberOfDailyEpisode
        if numberOfItems >= indexPath.row + 1 {
            let index = indexPath.row - (numberOfItems - numberOfDailyEpisode)
            return dailyEpisode.episodes[index]
        }
        return nil
    }
}





